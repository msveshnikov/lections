# encoding: utf-8
module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = 'Лекции'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def getfavs
    s = cookies[:fav]
    s = '' if s.blank?
    s.split(',')
  end

  def getfav(id)
    if getfavs.include? id.to_s
      return 'heart-on.jpg'
    else
      return 'heart-off.jpg'
    end
  end

end
