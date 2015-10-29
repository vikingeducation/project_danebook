module ProfilesHelper

  def describe_results(query, count)
    if query.empty?
      "Enter a name or a few letters above to search for a user."
    elsif count == 0
      "No results found for \"#{query}\"."
    else
      "Showing #{pluralize(count, 'user')} whose first or last names contain \"#{query}\""
    end
  end

end
