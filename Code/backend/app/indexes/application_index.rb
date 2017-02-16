class ApplicationIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      ngram: {
        tokenizer: :ngram_3_20,
        filter: %i(lowercase)
      },
      email: {
        type: 'custom',
        tokenizer: 'lowercase'
      }
    },
    tokenizer: {
      ngram_3_20: {
        type: :edgeNGram,
        min_gram: 3,
        max_gram: 20,
        token_chars: %i(letter digit)
      }
    }
  }
end
