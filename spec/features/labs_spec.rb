# frozen_string_literal: true
feature Lab do
  context '#unauthorized' do
    let(:document) { lab.document }
    let(:lab) { create :lab }

    scenario '#new' do
      visit new_document_lab_path document, lab
      expect(page).not_to have_content I18n.t 'labs.new.title'

      text = I18n.t 'devise.failure.unauthenticated'
      expect(page).to have_content text
    end

    scenario '#edit' do
      visit edit_lab_path lab
      expect(page).not_to have_content I18n.t 'labs.edit.title'
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
        %w(labs no-labs add).each do |string|
          text = I18n.t "labs.list.#{string}"
          expect(page).to have_content text
        end
      end
    end

    context '#with one lab' do
      let(:document) { lab.document }
      let(:lab) { create :lab }

      context '#create' do
        background do
          click_on I18n.t 'labs.list.add'

          %w(labs.new.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form lab
          click_on I18n.t 'helpers.submit.create'

          %w(flash.labs.create.notice
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          click_on I18n.t 'helpers.submit.create'

          text = I18n.t 'labs.new.title'
          expect(page).to have_content text

          %w(flash.labs.create.notice
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

          %w(labs.edit.title cancel).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with valid inputs' do
          fill_in_form lab
          click_button I18n.t 'helpers.submit.update'

          %w(flash.labs.update.notice
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end

        scenario '#with invalid inputs' do
          fill_in_form Lab.new
          click_button I18n.t 'helpers.submit.update'

          %w(flash.labs.update.notice
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
          %w(flash.labs.destroy.notice
             documents.edit.title).each do |string|
            expect(page).to have_content I18n.t string
          end
        end
      end
    end

    context '#with labs' do
      let(:lab) { labs.first }
      let(:labs) { document.labs }
      let(:document) { create :document_with_labs }

      background do
        find_link(I18n.t('documents.form.labs_and_practice')).click
      end

      scenario '#index' do
        labs.map(&:name).each do |name|
          expect(page).to have_content name
        end

        text = I18n.t 'labs.list.no-labs'
        expect(page).not_to have_content text
      end

      %w(lower higher).each do |type|
        scenario "#move #{type}", js: true do
          position = lab.position

          text = I18n.t "move-#{type}"
          first('a', text: text).click

          new_position = lab.reload.position
          expect(new_position).not_to eq position
        end
      end
    end
  end

  private

  def fill_in_form(lab)
    %i(name time_count).each do |field|
      selector = "lab[#{field}]"
      value = lab.send field
      fill_in selector, with: value
    end
  end
end
