require 'RMagick'

class Image < ActiveRecord::Base
  attr_accessible :filename, :md5, :taken_at

  has_and_belongs_to_many :categories

  before_validation :calculate_hash, :extract_date, :set_created_tag
  after_validation :create_thumbnail

  validates_uniqueness_of :md5

  def url_medium
    '/thumbs/medium/' + md5 + '.' + get_extension
  end

  def url_small
    '/thumbs/small/' + md5 + '.' + get_extension
  end

  def url_original
    filename
  end

  def previous_image
    self.class.first(:conditions => ["id > ?", self.id], :order => "id asc")
  end

  def next_image
    self.class.first(:conditions => ["id < ?", self.id], :order => "id desc")
  end

  def formated_date

    return 'N/A' if taken_at.nil?

    months = ['Janeiro', 'Fevereiro', 'Marco', 'Abril',
              'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro',
              'Outubro', 'Novembro', 'Dezembro']
    day, month, year = taken_at.day, months[taken_at.month], taken_at.year

    "Dia #{day} de #{month} de #{year}."
  end

  private

  def get_extension
    filename.split('.')[-1]
  end

  IMAGES_PATH = './public/images/'
  THUMBS_PATH = './public/thumbs/'

  def is_jpeg? filename
    ['jpeg','jpg','JPG','JPEG'].include? get_extension
  end

  def calculate_hash
    text = IO.read(IMAGES_PATH + filename)
    self.md5 = Digest::MD5.hexdigest(text)
  end

  def extract_date
    # only works for jpeg files for now
    if is_jpeg? filename
        begin
          date = EXIFR::JPEG.new(IMAGES_PATH + filename).date_time
          self.taken_at = date.to_date if date
        rescue
          Rails.logger.error filename
        end
    end
  end

  public
  def create_thumbnail

    # dont create in case of errors
    return if errors.size > 0

    small, medium = File.exists?('./public' + url_small), File.exists?('./public' + url_medium)

    unless medium && small
      begin
        img = Magick::Image.read(IMAGES_PATH + filename).first

        # medium thumb
        unless medium
          Rails.logger.puts 'Resizing medium ' + filename
          img.change_geometry("640x480") do |cols, rows, i|
            i.resize(cols, rows).write './public' + url_medium
          end
        end
        #small thumb
        unless small
          Rails.logger.puts 'Resizing small ' + filename
          img.change_geometry("150x95") do |cols, rows, i|
            i.resize(cols, rows).write './public' + url_small
          end
        end
      rescue Exception => e
        Rails.logger.puts e
      end
    end
  end

  def set_created_tag
     if taken_at
          year = taken_at.year
          c = Category.find_or_create_by_name(year.to_s)
          categories << c
     end
  end

end
