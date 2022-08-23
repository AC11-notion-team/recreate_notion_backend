require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = pages(:one)
  end

  test "should get index" do
    get pages_url, as: :json
    assert_response :success
  end

  test "should create page" do
    assert_difference('Page.count') do
      post pages_url, params: { page: { archived: @page.archived, cover: @page.cover, created_by: @page.created_by, icon: @page.icon, last_edited_by: @page.last_edited_by, object: @page.object, parent: @page.parent, properties: @page.properties, url: @page.url, uuid: @page.uuid } }, as: :json
    end

    assert_response 201
  end

  test "should show page" do
    get page_url(@page), as: :json
    assert_response :success
  end

  test "should update page" do
    patch page_url(@page), params: { page: { archived: @page.archived, cover: @page.cover, created_by: @page.created_by, icon: @page.icon, last_edited_by: @page.last_edited_by, object: @page.object, parent: @page.parent, properties: @page.properties, url: @page.url, uuid: @page.uuid } }, as: :json
    assert_response 200
  end

  test "should destroy page" do
    assert_difference('Page.count', -1) do
      delete page_url(@page), as: :json
    end

    assert_response 204
  end
end
