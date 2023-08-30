# frozen_string_literal: true

require 'test_helper'

class RecurrencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recurrence = recurrences(:one)
  end

  test 'should get index' do
    get recurrences_url
    assert_response :success
  end

  test 'should get new' do
    get new_recurrence_url
    assert_response :success
  end

  test 'should create recurrence' do
    assert_difference('Recurrence.count') do
      post recurrences_url,
           params: { recurrence: { category_id: @recurrence.category_id, date_expire: @recurrence.date_expire,
                                   title: @recurrence.title, user_profile_id: @recurrence.user_profile_id, price_cents: @recurrence.price_cents } }
    end

    assert_redirected_to recurrence_url(Recurrence.last)
  end

  test 'should show recurrence' do
    get recurrence_url(@recurrence)
    assert_response :success
  end

  test 'should get edit' do
    get edit_recurrence_url(@recurrence)
    assert_response :success
  end

  test 'should update recurrence' do
    patch recurrence_url(@recurrence),
          params: { recurrence: { category_id: @recurrence.category_id, date_expire: @recurrence.date_expire,
                                  title: @recurrence.title, user_profile_id: @recurrence.user_profile_id, price_cents: @recurrence.price_cents } }
    assert_redirected_to recurrence_url(@recurrence)
  end

  test 'should destroy recurrence' do
    assert_difference('Recurrence.count', -1) do
      delete recurrence_url(@recurrence)
    end

    assert_redirected_to recurrences_url
  end
end
