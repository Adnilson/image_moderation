# frozen_string_literal: true

RESULT_REGEX = /\A(approved|rejected)\z/

class Report < ApplicationRecord
  has_one_attached :image

  validates :user_id, :caller_url, presence: true, on: :create

  validates_format_of :result, with: RESULT_REGEX, if: :moderated?

  def moderated?
    moderated
  end
end
