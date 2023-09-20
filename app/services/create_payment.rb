# frozen_string_literal: true

class CreatePayment < ApplicationService
  def initialize(profile, bill, params)
    super
    @params   = params
    @profile  = profile
    @bill     = bill
    @account  = @profile.accounts.find(params.delete(:account_id))
    @category = @profile.categories.find(params.delete(:category_id))
  end

  def call
    ActiveRecord::Base.transaction do
      create_transaction

      @bill.paid!
      @bill.due_pay += Date.today.next_month.month
      @bill.save
    rescue ActiveRecord::RecordInvalid => e
      p e.message
    end

    @bill
  end

  def create_transaction
    @bill.transactions.build(
      account: @account,
      user_profile: @profile,
      category: @category,
      price_cents: @params[:price_cents],
      description: @params[:description],
      date: Date.today.to_datetime
    )
  end
end
