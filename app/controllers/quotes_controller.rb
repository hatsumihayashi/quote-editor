class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  def index
    @quotes = current_company.quotes.ordered
  end

  def show
    @line_item_dates = @quote.line_item_dates.ordered
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = current_company.quotes.build(quote_params)

    if @quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "見積りが追加されました" }
        format.turbo_stream { flash.now[:notice] = "見積りが追加されました" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "見積りが更新されました" }
        format.turbo_stream { flash.now[:notice] = "見積りが更新されました" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "見積りが削除されました" }
      format.turbo_stream { flash.now[:notice] = "見積りが削除されました" }
    end
  end

  private

  def set_quote
    @quote = current_company.quotes.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
