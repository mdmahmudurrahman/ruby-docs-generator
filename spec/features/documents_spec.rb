# frozen_string_literal: true
feature Document do
  context '#unauthorized' do
    scenario '#index' do
      visit root_path; expect(page).to have_content 'Log in'
    end
  end

  context '#authorized' do
    background do
      sign_in user
      visit root_path
    end

    context '#no documents' do
      let(:user) { create :user }
      let(:document) { build :document }

      scenario '#index' do
        %w(documents no-documents add).each do |string|
          text = I18n.t "documents.index.#{string}"
          expect(page).to have_content text
        end
      end

      scenario '#create' do
        text = I18n.t 'documents.index.add'
        find('a', text: text).click

        text = I18n.t 'documents.new.title'
        expect(page).to have_content text

        fill_document_form document
        click_button 'Добавить'

        text = I18n.t 'documents.create.alert'
        expect(page).to have_content text
      end

      scenario '#cancel create' do
        text = I18n.t 'documents.index.add'
        find('a', text: text).click

        text = I18n.t 'documents.new.title'
        expect(page).to have_content text

        find('a', text: I18n.t('cancel')).click
        text = I18n.t 'documents.create.alert'
        expect(page).not_to have_content text
      end
    end

    context '#with documents' do
      let(:user) { create :user_with_documents }
      let(:documents) { user.documents }

      scenario '#index' do
        %w(documents add).each do |string|
          text = I18n.t "documents.index.#{string}"
          expect(page).to have_content text
        end

        text = I18n.t 'documents.index.no-documents'
        expect(page).not_to have_content text

        documents.each do |document|
          text = document.discipline_name
          expect(page).to have_content text
        end
      end

      %w(update delete).each do |name|
        scenario "##{name} link", js: true do
          first('.glyphicon-option-vertical').hover
          expect(page).to have_content I18n.t name
        end
      end
    end

    context '#with one document' do
      let(:user) { document.user }
      let(:document) { create :document }

      scenario '#update', js: true do
        first('.glyphicon-option-vertical').hover
        expect(page).to have_content I18n.t 'update'

        find('.update-link').click

        text = I18n.t 'documents.edit.title'
        expect(page).to have_content text

        fill_document_form document
        click_button 'Сохранить'

        text = I18n.t 'documents.update.alert'
        expect(page).to have_content text
      end

      scenario '#cancel update', js: true do
        first('.glyphicon-option-vertical').hover
        expect(page).to have_content I18n.t 'update'

        find('.update-link').click

        text = I18n.t 'documents.edit.title'
        expect(page).to have_content text

        find('a', text: I18n.t('cancel')).click
        text = I18n.t 'documents.update.alert'
        expect(page).not_to have_content text
      end

      scenario '#destroy', js: true do
        first('.glyphicon-option-vertical').hover
        expect(page).to have_content I18n.t 'delete'

        find('.delete-link').click
        name = document.discipline_name
        expect(page).not_to have_content name

        %w(destroy.alert index.no-documents).each do |id|
          text = I18n.t "documents.#{id}"
          expect(page).to have_content text
        end
      end
    end
  end

  private

  def fill_document_form(document)
    select 'екзамен', from: 'document[type_of_control]'

    %i(discipline_code field_of_study_code discipline_name faculty_name labs_count credits_count field_of_study_name
       speciality_name specialization_name lectures_count semester_number year_of_studying self_hours_count
       total_hours_count).each { |field| fill_in "document[#{field}]", with: document.send(field) }
  end
end
