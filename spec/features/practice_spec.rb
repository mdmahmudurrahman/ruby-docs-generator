# frozen_string_literal: true
feature Practice, focus: true do
  context '#unauthorized' do
    let(:document) { practice.document }
    let(:practice) { create :practice }

    scenario '#new' do
      visit new_document_practice_path document, practice
      expect(page).not_to have_content I18n.t 'practices.new.title'

      text = I18n.t 'devise.failure.unauthenticated'
      expect(page).to have_content text
    end

    scenario '#edit' do
      visit edit_practice_path practice
      expect(page).not_to have_content I18n.t 'practices.edit.title'
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
        %w(practices no-practices add).each do |string|
          text = I18n.t "practices.list.#{string}"
          expect(page).to have_content text
        end
      end
    end

    context '#with one practice' do
      let(:document) { practice.document }
      let(:practice) { create :practice }

      context '#create' do
        background do
          click_on I18n.t 'practices.list.add'

          %w(practices.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form practice
          click_on I18n.t 'helpers.submit.create'

          %w(practices.create.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          text = I18n.t 'practices.new.title'
          expect(page).to have_content text

          %w(practices.create.alert
             documents.edit.title).each do |string|
            expect(page).not_to have_content I18n.t string
          end
          expect(page).to have_content I18n.t 'cancel'
        end
      end

      context '#update', js: true do
        background do
          find_link(I18n.t('documents.form.labs_and_practice')).click
          find('.glyphicon-option-vertical').hover
          find('.update-link').click

          %w(practices.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form practice
          click_button I18n.t 'helpers.submit.update'

          %w(practices.update.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_form Practice.new
          click_button I18n.t 'helpers.submit.update'

          %w(practices.update.alert
             documents.edit.title).each do |string|
            expect(page).not_to have_content I18n.t string
          end
        end
      end

      context '#delete', js: true do
        background do
          find_link(I18n.t('documents.form.labs_and_practice')).click
          find('.glyphicon-option-vertical').hover
          find('.delete-link').click
        end

        scenario '#delete' do
          %w(practices.destroy.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end
      end
    end

    context '#with practices' do
      let(:practice) { practices.first }
      let(:practices) { document.practices }
      let(:document) { create :document_with_practices }

      background do
        find_link(I18n.t('documents.form.labs_and_practice')).click
      end

      scenario '#index' do
        practices.map(&:name).each do |name|
          expect(page).to have_content name
        end

        text = I18n.t 'practices.list.no-practices'
        expect(page).not_to have_content text
      end

      %w(lower higher).each do |type|
        scenario "#move #{type}", js: true do
          position = practice.position

          text = I18n.t "move-#{type}"
          first('a', text: text).click

          new_position = practice.reload.position
          expect(new_position).not_to eq position
        end
      end
    end
  end

  private

  def fill_in_form(practice)
    %i(name time_count).each do |field|
      selector = "practice[#{field}]"
      value = practice.send field
      fill_in selector, with: value
    end
  end
end
