# 横ビンゴの検証
def side_by_side(size_number, block_number, card_word, chosen_word)
  n = 0
  while n + size_number-1 <= block_number do
    duplicate_array = card_word[n..n + size_number-1] & chosen_word
    duplicate_number = duplicate_array.length.to_i
    if  duplicate_number == size_number
      return true
    end
    n = n + size_number
  end
end

# 縦ビンゴの検証
def vartical(size_number, block_number, card_word, chosen_word)
  n = 0
  i = 0
  vartical_array = []
  while i <= size_number -1 do
    while n <= block_number - 1 do
      vartical_array << card_word[n]
      n = n + size_number
      duplicate_array = vartical_array & chosen_word
      duplicate_number = duplicate_array.length.to_i
    end
    if duplicate_number == size_number
      return true
    end
    vartical_array.clear
    n = i + 1
    i = i + 1
  end
end

# 斜めビンゴの検証(左上から右下)
def downword_right(size_number, block_number, card_word, chosen_word)
  n = 0
  downword_right_array =  []
  while n <= block_number - 1 do
    downword_right_array << card_word[n]
    n = n + size_number + 1
  end
  duplicate_array = downword_right_array & chosen_word
  duplicate_number = duplicate_array.length.to_i
  if duplicate_number == size_number
    return true
  end
end

# 斜めビンゴの検証(右上から左下)
def downword_left(size_number, block_number, card_word, chosen_word)
  n = size_number - 1
  downword_left_array = []
  while n <= block_number - 2 do
    downword_left_array << card_word[n]
    n = n + size_number - 1
  end
  duplicate_array = downword_left_array & chosen_word
  duplicate_number = duplicate_array.length.to_i
  if duplicate_number == size_number
    return true
  end
end

# ビンゴカードのサイズを入力
size_number = gets.to_i
unless size_number >= 3 && size_number <= 1000 && size_number.is_a?(Integer)
  puts "3以上、1000以下の整数を半角で入力してください。"
  exit
end

block_number = size_number ** 2  


# ビンゴカードに入れる単語の入力
n = 1
card_word = []
while n <= size_number 
  input_card = gets.split
  
  x = 0
  input_card.each do |input|
    if input.length < 1 || input.length > 100
      puts "1~100文字の単語を入力してください。"
      exit
    end
  end
  
  unless input_card.join =~ /\A[a-zA-Z0-9]+\z/
    puts "半角英数字で入力してください。"
    exit
  end

  card_word << input_card
  card_word.flatten!

  if card_word.length.to_i == size_number * n
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


# 単語数を1~2000の間で入力
word_number = gets.to_i
if word_number < size_number
  puts "マス目の数よりも大きな数を入力してください。"
  exit
elsif word_number < 1 || word_number > 2000
  puts "単語数は1~2000の間で入力してください。"
  exit
end

# word_number個の単語を入力
n = 1
chosen_word = []
while n <= word_number
  input_word = gets.chomp

  if input_word.length < 1 || input_word.length > 100
    puts "単語は1~100文字で入力してください。"
    exit
  end
  unless input_card.join =~ /\A[a-zA-Z0-9]+\z/
    puts "半角英数字で入力してください。"
    exit
  end

  chosen_word << input_word  

  if (chosen_word.count - chosen_word.uniq.count) >0
    puts "単語が重複しています。"
    exit
  end
  n += 1
end


# 判定メソッドの呼び出しと結果の出力
if side_by_side(size_number, block_number, card_word, chosen_word)
  puts "yes"
elsif vartical(size_number, block_number, card_word, chosen_word)
  puts "yes"
elsif downword_right(size_number, block_number, card_word, chosen_word)
  puts "yes"
elsif downword_left(size_number, block_number, card_word, chosen_word)
  puts "yes"
else
  puts "No"
end




