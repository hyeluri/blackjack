class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop()).last()
    @checkBlackJack()

  checkBlackJack: ->
    if @scores() is 21 or @scores() > 21
      @gameOver()

  stand: -> @trigger('turnOver', @)

  split: ->
    console.log @models

  gameOver: ->
    console.log 'game OVer!'
    if @scores() is 21
      console.log 'blackJack'
      console.log @
      @blackJack()
    if @scores() >21
      console.log 'busted'
      @busted()

  busted: ->
    @trigger('busted',@)
  blackJack: ->
    @trigger('blackJack',@)
    #finish the turn to the dealer. no more cards

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    # if hasAce then [score, score + 10] else [score, 1]
    finalScore =
      if hasAce
        if score + 10 < 22
          score + 10
        else
          score
      else
        score





