require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:task) { create(:task) }

  scenario "displaying tasks list" do
    visit tasks_path

    expect(page).to have_content task.name
  end

  context "creating a new task" do
    scenario "can create" do
      visit new_task_path

      fill_in "タスク名", with: "たすくのなまえ"
      select "doing", from: "ステータス"
      select "middle", from: "優先度"
      click_button '新規作成'

      expect(current_path).to eq tasks_path
      expect(page).to have_content "タスクを作成しました"
      expect(page).to have_content "たすくのなまえ"
    end

    scenario "can't create" do
      visit new_task_path

      click_button '新規作成'

      expect(page).to have_content "タスクの作成に失敗しました"
    end
  end

  context "updating a task" do
    scenario "can update" do
      visit edit_task_path(task)

      expect(page).to have_field "タスク名", with: task.name
      expect(page).to have_select("ステータス", selected: task.status)
      expect(page).to have_select("優先度", selected: task.priority)

      fill_in "タスク名", with: "あたらしいたすくのなまえ"
      click_button '更新'

      expect(current_path).to eq tasks_path
      expect(page).to have_content "タスクを更新しました"
      expect(page).to have_content "あたらしいたすくのなまえ"
    end

    scenario "can't update" do
      visit edit_task_path(task)

      name_field = find_field("タスク名")
      name_field.native.clear
      click_button '更新'

      expect(page).to have_content "タスクの更新に失敗しました"
    end
  end

  scenario "deleting a task" do
    visit tasks_path

    delete_button = find_link "削除"
    expect(delete_button['data-confirm']).to eq "本当に削除しますか？"

    accept_confirm do
      click_link "削除"
    end

    expect(page).to have_content "タスクを削除しました"
    expect(page).to_not have_content "task_name"
  end
end
