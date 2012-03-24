require 'active_record'

class Url < ActiveRecord::Base

  validates :url,
    :presence => true,
    :uniqueness => true
  validates :code,
    :presence => true,
    :uniqueness => true

  before_validation :set_code, :on => :create


  private
  def set_code
    self.code = [[Digest::MD5.hexdigest(url).to_i(13)].pack("N")].pack("m0").tr("+/", "-_").sub(/==\n?$/, '')
  end
end