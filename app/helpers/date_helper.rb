module DateHelper
  require 'date'
  
  def extract_selected_date(name, attrs)
    DateTime.strptime(attrs.values_at("#{name}(1i)", "#{name}(2i)", "#{name}(3i)") * "-",
    '%Y-%m-%d')
  end

end