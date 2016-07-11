class Api::V1::ResultsController < ApplicationController

  def index
    @bulletins = Bulletin.by_date
    @attachments = Attachment.by_date
    render
  end
end
