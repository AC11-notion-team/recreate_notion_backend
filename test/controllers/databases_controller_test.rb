require "test_helper"

class DatabasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @database = databases(:one)
  end

  test "should get index" do
    get databases_url, as: :json
    assert_response :success
  end

  test "should create database" do
    assert_difference('Database.count') do
      post databases_url, params: { database: { archived: @database.archived, cover: @database.cover, created_by: @database.created_by, description: @database.description, icon: @database.icon, is_inline: @database.is_inline, last_edited_by: @database.last_edited_by, object: @database.object, parent: @database.parent, properties: @database.properties, title: @database.title, url: @database.url, uuid: @database.uuid } }, as: :json
    end

    assert_response 201
  end

  test "should show database" do
    get database_url(@database), as: :json
    assert_response :success
  end

  test "should update database" do
    patch database_url(@database), params: { database: { archived: @database.archived, cover: @database.cover, created_by: @database.created_by, description: @database.description, icon: @database.icon, is_inline: @database.is_inline, last_edited_by: @database.last_edited_by, object: @database.object, parent: @database.parent, properties: @database.properties, title: @database.title, url: @database.url, uuid: @database.uuid } }, as: :json
    assert_response 200
  end

  test "should destroy database" do
    assert_difference('Database.count', -1) do
      delete database_url(@database), as: :json
    end

    assert_response 204
  end
end
