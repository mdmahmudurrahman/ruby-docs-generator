# frozen_string_literal: true
feature Topic do
  context '#unauthorized' do
    let(:topic) { create :topic }
    let(:sub_module) { topic.sub_module }

    scenario '#new' do
      visit new_sub_module_topic_path sub_module
      expect(page).not_to have_content I18n.t 'topics.new.title'
      expect(page).to have_content I18n.t 'devise.failure.unauthenticated'
    end

    scenario '#edit' do
      visit edit_topic_path topic
      expect(page).not_to have_content I18n.t 'topics.edit.title'
      expect(page).to have_content I18n.t 'devise.sessions.new.sign_in'
    end
  end

  context '#authorized' do
    let(:user) { sub_module.main_module.document.user }
    background { sign_in user; visit sub_module_path sub_module }

    context '#without topics' do
      let(:topic) { build :topic, labs_time: 2, lectures_time: 2 }
      let(:sub_module) { create :sub_module, labs_time: 6, lectures_time: 6 }

      scenario '#index' do
        %w(modules no-modules add).each do |string|
          text = I18n.t "topics.list.#{string}"
          expect(page).to have_content text
        end
      end

      context '#create', js: true do
        background do
          # open form for creating new topic
          click_on I18n.t 'topics.list.add'

          # check form name and controls
          %w(topics.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          # check absence of fields for labs and lectures
          # time - by default these fields are hidden
          %w(labs_time lectures_time).each do |string|
            text = I18n.t "simple_form.labels.topics.#{string}"
            expect(page).not_to have_content text
          end

          # check status of checkbox
          checkbox = find 'input[type="checkbox"]'
          expect(checkbox).to be_checked
        end

        scenario '#with valid name and checkbox' do
          # fill name field and submit the form
          fill_in 'topic[name]', with: topic.name
          click_on I18n.t 'helpers.submit.create'

          # check alert and add link
          %w(topics.list.add flash.topics.create.notice).each do |text|
            expect(page).to have_content I18n.t text
          end

          topic = sub_module.topics.first

          # check topic labs and lectures time
          %i(labs_time lectures_time).each do |field|
            expect(topic.send(field)).to eq 6
          end
        end

        scenario '#with valid name, labs and lectures time' do
          # change checkbox status for displaying
          # labs and lectures inputs
          find('input[type="checkbox"]').set false

          # fill name field and submit the form
          fill_in_topic_form topic
          click_on I18n.t 'helpers.submit.create'

          # check alert and add link
          %w(topics.list.add flash.topics.create.notice).each do |text|
            expect(page).to have_content I18n.t text
          end

          topic = sub_module.topics.first

          # check topic labs and lectures time
          %i(labs_time lectures_time).each do |field|
            expect(topic.send(field)).to eq 2
          end
        end
      end
    end

    context '#with one sub module', js: true do
      let(:topic) { create :topic }
      let(:sub_module) { topic.sub_module }

      context '#create', js: true do
        let(:topic) { create :topic, calculate_time: true }

        background do
          click_on I18n.t 'topics.list.add'

          %w(topics.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          %w(labs_time lectures_time).each do |string|
            text = I18n.t "simple_form.labels.topics.#{string}"
            expect(page).not_to have_content text
          end

          checkbox = find 'input[type="checkbox"]'
          expect(checkbox).to be_checked
        end

        scenario '#with valid name and checkbox' do
          # fill name field and submit the form
          fill_in 'topic[name]', with: topic.name
          click_on I18n.t 'helpers.submit.create'

          # check alert and add link
          %w(topics.list.add flash.topics.create.notice).each do |text|
            expect(page).to have_content I18n.t text
          end

          new_topic = sub_module.topics.last

          # check topic labs and lectures time
          %i(labs_time lectures_time).each do |field|
            expect(new_topic.send(field)).to eq \
              sub_module.send(field) / 2
          end
        end

        scenario '#with valid name, labs and lectures time' do
          # change checkbox status for displaying
          # labs and lectures inputs
          find('input[type="checkbox"]').set false

          # fill name field and submit the form
          fill_in_topic_form topic
          click_on I18n.t 'helpers.submit.create'

          # check alert and add link
          %w(topics.list.add flash.topics.create.notice).each do |text|
            expect(page).to have_content I18n.t text
          end

          new_topic = sub_module.topics.last

          # check topic labs and lectures time
          %i(labs_time lectures_time).each do |field|
            expect(new_topic.send(field)).to eq topic.send(field)
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          %w(topics.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          text = I18n.t 'flash.topics.create.notice'
          expect(page).not_to have_content text
        end
      end

      context '#update', js: true do
        let(:topic) { create :topic, calculate_time: false }

        background do
          find('.glyphicon-option-vertical').hover
          find('.update-link').click

          %w(topics.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_topic_form topic
          click_button I18n.t 'helpers.submit.update'

          %w(flash.topics.update.notice
             topics.list.add).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_topic_form Topic.new
          click_button I18n.t 'helpers.submit.update'

          %w(topics.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end

          text = I18n.t 'flash.topics.update.notice'
          expect(page).not_to have_content text
        end
      end

      context '#delete', js: true do
        background do
          find('.glyphicon-option-vertical').hover
          find('.delete-link').click
        end

        scenario '#delete' do
          expect(page).to have_content I18n.t 'flash.topics.destroy.notice'
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

        text = I18n.t 'topics.list.no-modules'
        expect(page).not_to have_content text
      end

      %w(lower higher).each do |type|
        scenario "#move #{type}", js: true do
          position = topic.position

          sleep 1
          text = I18n.t "move-#{type}"
          first('a', text: text).click

          new_position = topic.reload.position
          expect(new_position).not_to eq position
        end
      end
    end
  end

  private

  TOPIC_FIELDS = %i(name labs_time lectures_time).freeze

  def fill_in_topic_form(topic)
    TOPIC_FIELDS.each do |field|
      value = topic.send field
      selector = "topic[#{field}]"
      fill_in selector, with: value
    end
  end
end
