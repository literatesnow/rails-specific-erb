require 'test_helper'

class TodoItemTest < ActiveSupport::TestCase
  test 'should not save without title' do
    todo_item = TodoItem.new
    assert_not todo_item.save, 'Saved without a title'
  end

  test 'should not save with empty title' do
    todo_item = TodoItem.new
    todo_item.title = ''
    assert_not todo_item.save, 'Saved with empty title'
  end

  test 'should save successfully with minimum values' do
    todo_item = TodoItem.new
    todo_item.title = 'A'
    assert todo_item.save, 'Failed to save'
  end

  test 'should save successfully with all values' do
    todo_item = TodoItem.new
    todo_item.title     = 'This is a title'
    todo_item.text      = 'Text....'
    todo_item.due_at    = DateTime.now
    todo_item.completed = true
    assert todo_item.save, 'Failed to save'
  end
end
