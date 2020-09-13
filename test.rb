# 検証用メソッドの記載
# 横ビンゴの検証
def side_by_side(masu_number, block_number, card_word, chosen_word)
  n = 0
  while n + masu_number-1 <= block_number do
    duplicate_array = card_word[n..n + masu_number-1] & chosen_word
    duplicate_number = duplicate_array.length.to_i
    if  duplicate_number == masu_number
      return true
    end
    n = n + masu_number
  end
end

# 縦ビンゴの検証
def vartical(masu_number, block_number, card_word, chosen_word)
  n = 0
  i = 0
  vartical_array = []
  while i <= masu_number -1 do
    while n <= block_number - 1 do
      vartical_array << card_word[n]
      n = n + masu_number
      duplicate_array = vartical_array & chosen_word
      duplicate_number = duplicate_array.length.to_i
    end
    if duplicate_number == masu_number
      return true
    end
    vartical_array.clear
    n = i + 1
    i = i + 1
  end
end

# 斜めビンゴの検証(左上から右下)
def downword_right(masu_number, block_number, card_word, chosen_word)
  n = 0
  downword_right_array =  []
  while n <= block_number - 1 do
    downword_right_array << card_word[n]
    n = n + masu_number + 1
  end
  duplicate_array = downword_right_array & chosen_word
  duplicate_number = duplicate_array.length.to_i
  if duplicate_number == masu_number
    return true
  end
end

# 斜めビンゴの検証(右上から左下)
def downword_left(masu_number, block_number, card_word, chosen_word)
  n = masu_number - 1
  downword_left_array = []
  while n <= block_number - 2 do
    downword_left_array << card_word[n]
    n = n + masu_number - 1
  end
  duplicate_array = downword_left_array & chosen_word
  duplicate_number = duplicate_array.length.to_i
  if duplicate_number == masu_number
    return true
  end
end


# 入力の開始
# ビンゴカードのサイズS=masu_numberを入力してもらう
masu_number = gets.to_i
unless masu_number >= 3 && masu_number <= 1000 && masu_number.is_a?(Integer)
  puts "3以上、1000以下の整数を半角で入力してください。"
  exit
end

block_number = masu_number ** 2  #ビンゴのブロックの数を決定


# ビンゴカードの作成
# masu_number個の単語をmasu_number行入力してもらう。
n = 1
card_word = []
while n <= masu_number 
  input_card = gets.split
  # 入力されたmasu_number個の単語それぞれが1~100文字で入力されているか
  x = 0
  input_card.each do |input|
    if input.length < 1 || input.length > 100
      puts "1~100文字の単語を入力してください。"
      exit
    end
  end
  # 入力された単語が半角英数字であるか
  unless input_card.join =~ /\A[a-zA-Z0-9]+\z/
    puts "半角英数字で入力してください。"
    exit
  end

  # 入力された単語を配列に格納し、全ての要素をフラットにする
  card_word << input_card
  card_word.flatten!

  # 配列に格納された単語数が合っているか・単語の重複がないか確認
  if card_word.length.to_i == masu_number * n
    n += 1
  else
    puts "入力した単語の数が違います"
    exit
  end

  if (card_word.count - card_word.uniq.count) >0
    puts "単語が重複しています。"
    exit
  end
end


# ビンゴカードと照らし合わせる単語の入力
# 単語数を1~2000の間で入力してもらう。
word_number = gets.to_i
if word_number < masu_number
  puts "マス目の数よりも大きな数を入力してください。"
  exit
elsif word_number < 1 || word_number > 2000
  puts "単語数は1~2000の間で入力してください。"
  exit
end

# word_number個の単語を入力してもらう。
n = 1
chosen_word = []
while n <= word_number
  input_word = gets.chomp

  # 入力された単語が1~100文字の半角英数字で入力されているか確認
  if input_word.length < 1 || input_word.length > 100
    puts "単語は1~100文字で入力してください。"
    exit
  end
  unless input_card.join =~ /\A[a-zA-Z0-9]+\z/
    puts "半角英数字で入力してください。"
    exit
  end

  chosen_word << input_word   #入力された単語を配列に格納

  # chosen_word配列内に重複がないか確認
  if (chosen_word.count - chosen_word.uniq.count) >0
    puts "単語が重複しています。"
    exit
  end
  n += 1
end


# 判定メソッドの呼び出しと結果の出力
if side_by_side(masu_number, block_number, card_word, chosen_word)
  puts "yes"
elsif vartical(masu_number, block_number, card_word, chosen_word)
  puts "yes"
elsif downword_right(masu_number, block_number, card_word, chosen_word)
  puts "yes"
elsif downword_left(masu_number, block_number, card_word, chosen_word)
  puts "yes"
else
  puts "No"
end




