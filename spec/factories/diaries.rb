FactoryBot.define do
  factory :diary do
    association :user
    title { "穏やかな一日" }
    body { "今日は散歩をして気持ちがよかった。" }
    written_on { Date.current }
  end
end
