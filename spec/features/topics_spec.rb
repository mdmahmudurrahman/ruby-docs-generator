# frozen_string_literal: true
feature Topic do
  context '#unauthorized' do
    let(:topic) { create :topic }
    let(:sub_module) { topic.sub_module }
    let(:main_module) { sub_module.main_module }

    scenario '#show' do
      visit sub_module_topic_path sub_module, topic
      expect(page).not_to have_content topic.name

      text = I18n.t 'devise.sessions.new.sign_in'
      expect(page).to have_content text
    end

    scenario '#new' do
      visit new_sub_module_topic_path main_module, sub_module
      expect(page).not_to have_content I18n.t 'topics.new.title'

      text = I18n.t 'devise.failure.unauthenticated'
      expect(page).to have_content text
    end

    scenario '#edit' do
      visit edit_sub_module_topic_path main_module, sub_module
      expect(page).not_to have_content I18n.t 'topics.edit.title'

      text = I18n.t 'devise.sessions.new.sign_in'
      expect(page).to have_content text
    end
  end

  context '#authorized' do
    let(:user) { main_module.document.user }
    let(:main_module) { sub_module.main_module }

    background { sign_in user }
    background { visit main_module_sub_module_path main_module, sub_module }

    context '#without submodules' do
      let(:sub_module) { create :sub_module }

      scenario '#index' do
        %w(modules no-modules add).each do |string|
          text = I18n.t "topics.list.#{string}"
          expect(page).to have_content text
        end
      end
    end

    context '#with one sub module' do
      let(:topic) { create :topic }
      let(:sub_module) { topic.sub_module }

      context '#create' do
        background do
          click_on I18n.t 'topics.list.add'

          %w(topics.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form topic
          click_on I18n.t 'helpers.submit.create'

          %w(topics.create.alert
             topics.list.add).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          %w(topics.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          text = I18n.t 'topics.create.alert'
          expect(page).not_to have_content text
        end
      end

      context '#update', js: true do
        background do
          find('.glyphicon-option-vertical').hover
          find('.update-link').click

          %w(topics.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form topic
          click_button I18n.t 'helpers.submit.update'

          %w(topics.update.alert
             topics.list.add).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_form Topic.new
          click_button I18n.t 'helpers.submit.update'

          %w(topics.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          text = I18n.t 'topics.update.alert'
          expect(page).not_to have_content text
        end
      end

      context '#delete', js: true do
        background do
          find('.glyphicon-option-vertical').hover
          find('.delete-link').click
        end

        scenario '#delete' do
          expect(page).to have_content I18n.t 'topics.destroy.alert'
          expect(page).to have_content sub_module.name
        end
      end
    end

    context '#with many topics' do
      let(:topic) { topics.first }
      let(:topics) { sub_module.topics }
      let(:sub_module) { create :sub_module_with_topics }

      scenario '#index' do
        topics.map(&:name).each do |name|
          expect(page).to have_content name
        end

        text = I18n.t 'sub_modules.list.no-modules'
        expect(page).not_to have_content text
      end

      %w(lower higher).each do |type|
        scenario "#move #{type}", js: true do
          position = topic.position

          text = I18n.t "move-#{type}"
          first('a', text: text).click

          new_position = topic.reload.position
          expect(new_position).not_to eq position
        end
      end
    end
  end

  private

  def fill_in_form(topic)
    name = topic.name
    selector = 'topic[name]'
    fill_in selector, with: name
  end
end
