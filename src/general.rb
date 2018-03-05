class General
  attr_accessor :rules
  attr_accessor :about
  RULES_DOCUMENT_PATH = "data/rules.txt"
  ABOUT_DOCUMENT_PATH = "data/about.txt"
  def initialize()
    @rules = load_from_document(RULES_DOCUMENT_PATH)
    @about = load_from_document(ABOUT_DOCUMENT_PATH)
  end

  def get_rules()
    return RULES
  end

  def load_from_document(document)
    rules = ""
    r = File.read(document)
    r.each_line() do |line|
      rules << line
    end
    return rules
  end
end

g = General.new
puts g.rules
puts g.about
