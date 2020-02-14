require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:task) { create(:task) }
  let!(:task2) { create(:task, name: "task2", deadline: Time.current - 1.day, created_at: Time.current + 1.day) }
  let!(:task3) { create(:task, name: "task3", deadline: Time.current + 2.days, created_at: Time.current + 2.days) }
  let!(:task4) { create(:task, name: "task4", deadline: Time.current - 3.days, created_at: Time.current + 3.days) }

  context "displaying tasks" do
    context "in DESC order of 'created_at'" do
      scenario "without selecting sort" do
        visit tasks_path

        first_task = all('h2')[0]
        second_task = all('h2')[1]
        third_task = all('h2')[2]
        fourth_task = all('h2')[3]

        expect(first_task).to have_content task4.name
        expect(second_task).to have_content task3.name
        expect(third_task).to have_content task2.name
        expect(fourth_task).to have_content task.name
      end

      scenario "with selecting sort" do
        visit tasks_path

        within '.created_at_sort' do
          click_link '▼'
        end
        sleep 0.2

        first_task = all('h2')[0]
        second_task = all('h2')[1]
        third_task = all('h2')[2]
        fourth_task = all('h2')[3]

        expect(first_task).to have_content task4.name
        expect(second_task).to have_content task3.name
        expect(third_task).to have_content task2.name
        expect(fourth_task).to have_content task.name
      end
    end

    scenario "in ASC order of 'created_at'" do
      visit tasks_path

      within '.created_at_sort' do
        click_link '▲'
      end
      sleep 0.2

      first_task = all('h2')[0]
      second_task = all('h2')[1]
      third_task = all('h2')[2]
      fourth_task = all('h2')[3]

      expect(first_task).to have_content task.name
      expect(second_task).to have_content task2.name
      expect(third_task).to have_content task3.name
      expect(fourth_task).to have_content task4.name
    end

    scenario "in DESC order of 'deadline'" do
      visit tasks_path

      within '.deadline_sort' do
        click_link '▼'
      end
      sleep 0.2

      first_task = all('h2')[0]
      second_task = all('h2')[1]
      third_task = all('h2')[2]
      fourth_task = all('h2')[3]

      expect(first_task).to have_content task3.name
      expect(second_task).to have_content task.name
      expect(third_task).to have_content task2.name
      expect(fourth_task).to have_content task4.name
    end

    scenario "in ASC order of 'deadline'" do
      visit tasks_path

      within '.deadline_sort' do
        click_link '▲'
      end
      sleep 0.2

      first_task = all('h2')[0]
      second_task = all('h2')[1]
      third_task = all('h2')[2]
      fourth_task = all('h2')[3]

      expect(first_task).to have_content task4.name
      expect(second_task).to have_content task2.name
      expect(third_task).to have_content task.name
      expect(fourth_task).to have_content task3.name
    end
  end

  context "creating a new task" do
    scenario "can create" do
      visit new_task_path

      fill_in "タスク名", with: "たすくのなまえ"
      select "着手", from: "ステータス"
      select "中", from: "優先度"
      click_button '登録する'

      expect(current_path).to eq tasks_path
      expect(page).to have_content "タスクを作成しました"
      expect(page).to have_content "たすくのなまえ"
    end

    scenario "can't create" do
      visit new_task_path

      click_button '登録する'

      expect(page).to have_content "タスクの作成に失敗しました"
    end
  end

  context "updating a task" do
    scenario "can update" do
      visit edit_task_path(task)

      expect(page).to have_field "タスク名", with: task.name
      expect(page).to have_select("ステータス", selected: "着手")
      expect(page).to have_select("優先度", selected: "高")

      fill_in "タスク名", with: "あたらしいたすくのなまえ"
      click_button '更新する'

      expect(current_path).to eq tasks_path
      expect(page).to have_content "タスクを更新しました"
      expect(page).to have_content "あたらしいたすくのなまえ"
    end

    scenario "can't update" do
      visit edit_task_path(task)

      name_field = find_field("タスク名")
      name_field.native.clear
      click_button '更新する'

      expect(page).to have_content "タスクの更新に失敗しました"
    end
  end

  context "deleting a task" do
    scenario "can delete" do
      visit tasks_path

      delete_button = find_link "削除", match: :first
      expect(delete_button['data-confirm']).to eq "本当に削除しますか？"

      accept_confirm do
        click_link "削除", match: :first
      end

      expect(page).to have_content "タスクを削除しました"
      expect(page).to_not have_content "task4"
    end
  end
end
