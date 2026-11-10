module CommandArguments
  DANGEROUS_CHARS = /[$&;<>|`\\\n\r]/

  def self.sanitize(args)
    args
      .to_s
      .encode("UTF-8", invalid: :replace, undef: :replace, replace: '')
      .strip
      .gsub(DANGEROUS_CHARS, "")
  end
end
