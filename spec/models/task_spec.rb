require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with name, status and priority" do
    task = Task.new(
      name: "task",
      status: "doing",
      priority: "high",
    )

    expect(task).to be_valid
  end

  it "is invalid without name" do
    task = build(:task, name: nil)
    task.valid?

    expect(task.errors[:name]).to include("を入力してください")
  end

  it "is invalid without status" do
    task = build(:task, status: nil)
    task.valid?

    expect(task.errors[:status]).to include("を入力してください")
  end

  it "is invalid without priority" do
    task = build(:task, priority: nil)
    task.valid?

    expect(task.errors[:priority]).to include("を入力してください")
  end
end
