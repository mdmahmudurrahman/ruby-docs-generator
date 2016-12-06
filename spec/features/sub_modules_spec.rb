# frozen_string_literal: true
feature SubModule do
  context '#unauthorized' do
    let(:document) { main_module.document }
    let(:sub_module) { create :sub_module }
    let(:main_module) { sub_module.main_module }

    scenario '#show' do
      visit sub_module_path sub_module
      expect(page).not_to have_content sub_module.name
      expect(page).to have_content I18n.t 'devise.sessions.new.sign_in'
    end

    scenario '#new' do
      visit new_main_module_sub_module_path main_module, sub_module
      expect(page).not_to have_content I18n.t 'sub_modules.new.title'
      expect(page).to have_content I18n.t 'devise.failure.unauthenticated'
    end

    scenario '#edit' do
      visit edit_sub_module_path sub_module
      expect(page).not_to have_content I18n.t 'sub_modules.edit.title'
      expect(page).to have_content I18n.t 'devise.sessions.new.sign_in'
    end
  end

  context '#authorized' do
    let(:user) { document.user }
    let(:document) { main_module.document }
    background { sign_in user; visit main_module_path main_module }

    context '#without submodules' do
      let(:main_module) { create :main_module }

      scenario '#index' do
        %w(modules no-modules add).each do |string|
          text = I18n.t "sub_modules.list.#{string}"
          expect(page).to have_content text
        end
      end
    end

    context '#with one sub module' do
      let(:sub_module) { create :sub_module }
      let(:main_module) { sub_module.main_module }

      context '#create' do
        background do
          click_on I18n.t 'sub_modules.list.add'

          %w(sub_modules.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form sub_module
          click_on I18n.t 'helpers.submit.create'

          %w(flash.sub_modules.create.notice
             sub_modules.list.add).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          %w(sub_modules.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          text = I18n.t 'flash.sub_modules.create.notice'
          expect(page).not_to have_content text
        end
      end

      context '#update', js: true do
        background do
          find('.glyphicon-option-vertical').hover
          find('.update-link').click

          %w(sub_modules.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form sub_module
          click_button I18n.t 'helpers.submit.update'

          %w(flash.sub_modules.update.notice
             sub_modules.list.add).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_form SubModule.new
          click_button I18n.t 'helpers.submit.update'

          %w(sub_modules.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          text = I18n.t 'flash.sub_modules.update.notice'
          expect(page).not_to have_content text
        end
      end

      context '#delete', js: true do
        background do
          find('.glyphicon-option-vertical').hover
          find('.delete-link').click
        end

        scenario '#delete' do
          text = I18n.t 'flash.sub_modules.destroy.notice'
          expect(page).to have_content text

          expect(page).to have_content main_module.name
        end
      end
    end

    context '#with modules' do
      let(:sub_module) { sub_modules.first }
      let(:sub_modules) { main_module.sub_modules }
      let(:main_module) { create :main_module_with_sub_modules }

      scenario '#index' do
        sub_modules.map(&:name).each do |name|
          expect(page).to have_content name
        end

        text = I18n.t 'sub_modules.list.no-modules'
        expect(page).not_to have_content text
      end

      %w(lower higher).each do |type|
        scenario "#move #{type}", js: true do
          position = sub_module.position

          sleep 1
          text = I18n.t "move-#{type}"
          first('a', text: text).click

          new_position = sub_module.reload.position
          expect(new_position).not_to eq position
        end
      end
    end
  end

  private

  def fill_in_form(sub_module)
    %i(name labs_time lectures_time).each do |field|
      selector = "sub_module[#{field}]"
      value = sub_module.send field
      fill_in selector, with: value
    end
  end
end
