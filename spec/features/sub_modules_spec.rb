feature SubModule, focus: true do
  context '#unauthorized' do
    let(:document) { main_module.document }
    let(:sub_module) { create :sub_module }
    let(:main_module) { sub_module.main_module }

    scenario '#show' do
      name = sub_module.name
      visit url_for [main_module, sub_module]
      expect(page).not_to have_content name
    end

    %i(new edit).each do |action|
      scenario "##{action}" do
        visit url_for [action, main_module, sub_module]
        text = I18n.t "sub_modules.#{action}.title"
        expect(page).not_to have_content text
      end
    end
  end

  context '#authorized' do
    let(:user) { document.user }
    let(:document) { main_module.document }

    background { sign_in user; visit url_for [document, main_module] }

    context '#without submodules' do
      let(:main_module) { create :main_module }

      scenario '#index' do
        %w(modules no-modules add).each do |string|
          text = I18n.t "sub_modules.list.#{string}"
          expect(page).to have_content text
        end
      end
    end

    context '#with one submodule' do
      let(:main_module) { sub_module.main_module }
      let(:sub_module) { create :sub_module }

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

          %w(sub_modules.create.alert
             sub_modules.list.add).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          expect(page).not_to have_content I18n.t 'sub_modules.create.alert'
          expect(page).to have_content I18n.t 'sub_modules.new.title'
          expect(page).to have_content I18n.t 'cancel'
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

          %w(main_modules.update.alert
             sub_modules.list.add).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_form SubModule.new
          click_button I18n.t 'helpers.submit.update'

          expect(page).not_to have_content I18n.t 'sub_modules.update.alert'
          expect(page).to have_content I18n.t 'sub_modules.edit.title'
          expect(page).to have_content I18n.t 'cancel'
        end
      end
    end

    context '#with modules' do
      let(:sub_modules) { main_module.sub_modules }
      let(:main_module) { create :main_module_with_sub_modules }

      scenario '#index' do
        sub_modules.map(&:name).each do |name|
          expect(page).to have_content name
        end

        text = I18n.t 'sub_modules.list.no-modules'
        expect(page).not_to have_content text
      end
    end
  end

  private

  def fill_in_form(sub_module)
    %i(name labs_count lectures_count).each do |field|
      selector = "sub_module[#{field}]"
      value = sub_module.send field
      fill_in selector, with: value
    end
  end
end
