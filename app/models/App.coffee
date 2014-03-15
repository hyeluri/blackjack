#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    dealerH = @get 'dealerHand'
    playerH = @get 'playerHand'

    playerH.on 'turnOver', =>
      if dealerH.models.length < 3
        dealerH.models[0].flip()

      while (dealerH.scores()[0] < 21 and dealerH.scores()[1] < 17) or (dealerH.scores()[0] < 17 and dealerH.scores()[1] > 21)
        if dealerH.scores()[0] < 17
          dealerH.hit()
        else
          dealerH.gameOver()
          console.log(dealerH.scores())
          break

    dealerH.on 'gameSet', =>
      dealerScore  = if dealerH.scores()[0] > dealerH.scores()[1] then dealerH.scores()[0] else dealerH.scores()[1]
      playerScore =
        if playerH.scores()[1] > 21
          playerH.scores()[0]
        else if playerH.scores()[1] is 1
          playerH.scores()[0]
        else playerH.scores()[1]
      console.log "dealer #{dealerScore} player #{playerScore}"
      if dealerScore is playerScore
        alert "draw!"
      if dealerScore > playerScore
        alert "you lose"
      else
        alert "you win"



    #make all the plays required for the dealer and finish the hand

    # @get('dealerHand').on()
