require 'rexml/parsers/pullparser'

class String
  def truncate_html(len = 30)
    p = REXML::Parsers::PullParser.new(self)
    tags = []
    new_len = len
    results = ''
    while p.has_next? && new_len > 0
      p_e = p.pull
      case p_e.event_type
      when :start_element
        tags.push p_e[0]
        results << "<#{tags.last} #{attrs_to_s(p_e[1])}>"
      when :end_element
        results << "</#{tags.pop}>"
      when :text

        # breaks text node to words
        p_e[0].split(/[\s]+/).each_with_index do |word, i| 
          #adds space if not first word in node
          results << " " if i > 0

          results << word

          #do not count if empty. e.g. between <tag> and space
          new_len -= 1 if word.match(/[\w]+/)

          #stop loop if out of limit
          break unless new_len > 0
        end
      else
        results << "<!-- #{p_e.inspect} -->"
      end
    end
    tags.reverse.each do |tag|
      results << "</#{tag}>"
    end
    results
  end

  private

  def attrs_to_s(attrs)
    if attrs.empty?
      ''
    else
      attrs.to_a.map { |attr| %{#{attr[0]}="#{attr[1]}"} }.join(' ')
    end
  end
end