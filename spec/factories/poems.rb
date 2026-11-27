FactoryBot.define do
  factory :poem do
    sequence(:number) { |n| n }
    kami_no_ku { "秋の田の かりほの庵の 苫をあらみ" }
    shimo_no_ku { "わが衣手は 露にぬれつつ" }
    poet { "天智天皇" }
    translation { "秋の田のそばにある仮小屋の屋根の苫の編み目が粗いので、私の着物の袖は夜露にぬれてしまうことだ。" }
    explanation { "農民の苦労を思いやる天皇の御製とされています。" }
  end
end
