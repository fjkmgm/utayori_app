require "yaml"

PoemKeyword.destroy_all
Keyword.destroy_all
Poem.destroy_all
Diary.update_all(poem_id: nil)

puts "既存データをクリアしました。YAMLファイルから初期データをインポートします..."

yaml_path = Rails.root.join("db", "data", "poems.yml")
poems_data = YAML.load_file(yaml_path)

poems_data.each do |p_hash|
  keywords = p_hash.delete("keywords")

  poem = Poem.create!(
    number: p_hash["number"],
    kami_no_ku: p_hash["kami_no_ku"],
    shimo_no_ku: p_hash["shimo_no_ku"],
    poet: p_hash["poet"],
    translation: p_hash["translation"],
    explanation: p_hash["explanation"]
  )

  keywords.each do |kw_name|
    keyword = Keyword.find_or_create_by!(name: kw_name)
    PoemKeyword.create!(poem: poem, keyword: keyword)
  end
end

puts "初期データのインポートが完了しました！（Poem: #{Poem.count}件, Keyword: #{Keyword.count}件, PoemKeyword: #{PoemKeyword.count}件）"