require 'test_helper'

class TodoItemFlowTest < ActionDispatch::IntegrationTest
  test 'can view empty todo list page' do
    empty_index_todo_list
  end

  test 'can create a new todo' do
    create_todo
  end

  test 'view todo in list' do
    create_todo
    index_todo_list
  end

  test 'edit todo from list' do
    create_todo
    index_todo_list

    todo_item = TodoItem.last

    get "/todo_items/#{todo_item.id}/edit"
    assert_response :success

    mock = mock_todo_item(nil)

    post '/todo_items', params: { todo_item: mock }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    verify_view_todo_item mock
  end

  test 'delete todo from list' do
    create_todo
    index_todo_list

    todo_item = TodoItem.last

    delete "/todo_items/#{todo_item.id}"

    empty_index_todo_list
  end

  def create_todo
    get '/todo_items/new'
    assert_response :success

    mock = mock_todo_item(due_at: DateTime.now + 28.days,
                          due_at_text: '28 days')

    post '/todo_items', params: { todo_item: mock }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    verify_view_todo_item mock
  end

  def empty_index_todo_list
    get '/'
    assert_select 'h1', 'Todo List'
    assert_select 'div', /Create a new todo/
  end

  def index_todo_list
    get '/'

    mock = mock_todo_item nil

    assert_select 'a',  mock[:title]
    assert_select 'td', mock[:text]
  end

  def verify_view_todo_item(todo_item)
    assert_select 'h1', 'View Todo'
    assert_select 'table' do
      assert_select 'tr:nth-child(1) > td > span:first-child', todo_item[:title]
      assert_select 'tr:nth-child(1) > td > span:last-child',  'Completed' if todo_item[:completed]
      assert_select 'tr:nth-child(2) > td', todo_item[:text]
      assert_select 'tr:nth-child(3) > td', todo_item[:due_at_text]
      assert_select 'tr:nth-child(4) > td', todo_item[:updated_at_text]
      assert_select 'tr:nth-child(5) > td', todo_item[:created_at_text]
    end
  end

  def mock_todo_item(mock)
    todo_item = { title:       'The title',
                  text:        'The text',
                  completed:   true,
                  due_at:      nil,
                  due_at_text: '',
                  updated_at_text: 'less than a minute',
                  created_at_text: 'less than a minute' }
    todo_item.merge! mock unless mock.nil?
    todo_item
  end
end
