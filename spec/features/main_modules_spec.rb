# frozen_string_literal: true
feature MainModule do
  context '#unauthorized' do
    let(:document) { main_module.document }
    let(:main_module) { create :main_module }

    scenario '#show' do
      visit document_main_module_path document, main_module
      expect(page).not_to have_content main_module.name

      text = I18n.t 'devise.sessions.new.sign_in'
      expect(page).to have_content text
    end

    scenario '#new' do
      visit document_main_module_path document, main_module
      expect(page).not_to have_content I18n.t 'main_modules.new.title'

      text = I18n.t 'devise.sessions.new.sign_in'
      expect(page).to have_content text
    end

    scenario '#edit' do
      visit edit_document_main_module_path document, main_module
      expect(page).not_to have_content I18n.t 'main_modules.edit.title'

      text = I18n.t 'devise.sessions.new.sign_in'
      expect(page).to have_content text
    end
  end

  context '#authorized' do
    let(:user) { document.user }
    background { sign_in user }

    background { visit document_path document }

    context '#without modules' do
      let(:document) { create :document }

      scenario '#index' do
        %w(modules no-modules add).each do |string|
          text = I18n.t "main_modules.list.#{string}"
          expect(page).to have_content text
        end
      end
    end

    context '#with one module' do
      let(:document) { main_module.document }
      let(:main_module) { create :main_module }

      context '#create' do
        background do
          click_on I18n.t 'main_modules.list.add'

          %w(main_modules.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form main_module
          click_on I18n.t 'helpers.submit.create'

          %w(main_modules.create.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          text = I18n.t 'main_modules.new.title'
          expect(page).to have_content text

          %w(main_modules.create.alert
             documents.edit.title).each do |string|
            expect(page).not_to have_content I18n.t string
          end
          expect(page).to have_content I18n.t 'cancel'
        end
      end

      context '#update', js: true do
        background do
          find('.glyphicon-option-vertical').hover
          find('.update-link').click

          %w(main_modules.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form main_module
          click_button I18n.t 'helpers.submit.update'

          %w(main_modules.update.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_form MainModule.new
          click_button I18n.t 'helpers.submit.update'

          %w(main_modules.update.alert
             documents.edit.title).each do |string|
            expect(page).not_to have_content I18n.t string
          end
        end
      end

      context '#delete', js: true do
        background do
          find('.glyphicon-option-vertical').hover
          find('.delete-link').click
        end

        scenario '#delete' do
          %w(main_modules.destroy.alert
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end
      end
    end

    context '#with modules' do
      let(:main_modules) { document.main_modules }
      let(:document) { create :document_with_main_modules }

      scenario '#index' do
        main_modules.map(&:name).each do |name|
          expect(page).to have_content name
        end

        text = I18n.t 'main_modules.list.no-modules'
        expect(page).not_to have_content text
      end
    end
  end

  private

  def fill_in_form(main_module)
    %i(name total_time).each do |field|
      selector = "main_module[#{field}]"
      value = main_module.send field
      fill_in selector, with: value
    end
  end
end
