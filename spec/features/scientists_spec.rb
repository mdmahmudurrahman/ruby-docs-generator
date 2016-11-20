# frozen_string_literal: true
feature Scientist do
  context '#unauthorized' do
    let(:document) { scientist.document }
    let(:scientist) { create :scientist }

    scenario '#new' do
      visit new_document_scientist_path document, scientist
      expect(page).not_to have_content I18n.t 'scientists.new.title'

      text = I18n.t 'devise.failure.unauthenticated'
      expect(page).to have_content text
    end

    scenario '#edit' do
      visit edit_scientist_path scientist
      expect(page).not_to have_content I18n.t 'scientists.edit.title'
      expect(page).to have_content I18n.t 'devise.sessions.new.sign_in'
    end
  end

  context '#authorized' do
    let(:user) { document.user }
    background { sign_in user }

    background { visit document_path document }

    context '#without modules' do
      let(:document) { create :document }

      scenario '#index' do
        %w(scientists no-scientists add).each do |string|
          text = I18n.t "scientists.list.#{string}"
          expect(page).to have_content text
        end
      end
    end

    context '#with one scientist' do
      let(:document) { scientist.document }
      let(:scientist) { create :scientist }

      context '#create' do
        background do
          click_on I18n.t 'scientists.list.add'

          %w(scientists.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form scientist
          click_on I18n.t 'helpers.submit.create'

          %w(scientists.create.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          text = I18n.t 'scientists.new.title'
          expect(page).to have_content text

          %w(scientists.create.alert
             documents.edit.title).each do |string|
            expect(page).not_to have_content I18n.t string
          end
          expect(page).to have_content I18n.t 'cancel'
        end
      end

      context '#update', js: true do
        background do
          find_link(I18n.t('documents.form.modules_and_scientists')).click
          find('.glyphicon-option-vertical').hover
          find('.update-link').click

          %w(scientists.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form scientist
          click_button I18n.t 'helpers.submit.update'

          %w(scientists.update.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_form Scientist.new
          click_button I18n.t 'helpers.submit.update'

          %w(scientists.update.alert
             documents.edit.title).each do |string|
            expect(page).not_to have_content I18n.t string
          end
        end
      end

      context '#delete', js: true do
        background do
          find_link(I18n.t('documents.form.modules_and_scientists')).click
          find('.glyphicon-option-vertical').hover
          find('.delete-link').click
        end

        scenario '#delete' do
          %w(scientists.destroy.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end
      end
    end

    context '#with scientists' do
      let(:scientist) { scientists.first }
      let(:scientists) { document.scientists }
      let(:document) { create :document_with_scientists }

      background do
        find_link(I18n.t('documents.form.modules_and_scientists')).click
      end

      scenario '#index' do
        scientists.map(&:name).each do |name|
          expect(page).to have_content name
        end

        text = I18n.t 'scientists.list.no-scientists'
        expect(page).not_to have_content text
      end
    end
  end

  private

  def fill_in_form(scientist)
    %i(name position).each do |field|
      selector = "scientist[#{field}]"
      value = scientist.send field
      fill_in selector, with: value
    end
  end
end
