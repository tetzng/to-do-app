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
    task = Task.new(name: nil)
    task.valid?

    expect(task.errors[:name]).to include("can't be blank")
  end

  it "is invalid without status" do
    task = Task.new(status: nil)
    task.valid?

    expect(task.errors[:status]).to include("can't be blank")
  end

  it "is invalid without priority" do
    task = Task.new(priority: nil)
    task.valid?

    expect(task.errors[:priority]).to include("can't be blank")
  end
end
