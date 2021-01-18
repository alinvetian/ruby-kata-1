module CommonMethods

  def print_authors
    emails = authors.split(',')
    authors_by_email = $authors.group_by(&:email)
    emails.each do |email|
      authors_by_email[email].first.print
    end
    return
  end
end
