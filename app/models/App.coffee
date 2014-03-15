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
        if dealerH.scores() > 16
          dealerH.gameOver()
      while dealerH.scores() < 17
        dealerH.hit()

      if dealerH.scores()<21
        if dealerH.scores() > playerH.scores()
          alert 'dealer wins!'
        else if dealerH.scores() is playerH.scores()
          alert 'draw!'
        else
          alert 'player wins'

    playerH.on 'busted', =>
      alert "player busted"

    playerH.on 'blackJack', =>
      alert "player blackJack!"

    dealerH.on 'busted', =>
      alert "dealer busted"

    dealerH.on 'blackJack', =>
      console.log 'blackJack listened!'
      alert "dealer blackJack!"

    setTimeout(->
      playerH.checkBlackJack()
      0)

    #on click, if the player has 2 of the same value cards, 
    # we split the plyers hand, and hit on each of them
    # 


    # dealerH.on 'gameSet', =>
    #   if dealerH.scores() > playerH.scores()
    #     alert 'dealer wins!'
    #   if dealerH.scores() is playerH.scores()
    #     alert 'draw!'
    #   else
    #     alert 'you WIN!'

    #   while (dealerH.scores()[0] < 21 and dealerH.scores()[1] < 17) or (dealerH.scores()[0] < 17 and dealerH.scores()[1] > 21)
    #     if dealerH.scores()[0] < 17
    #       dealerH.hit()
    #     else
    #       dealerH.gameOver()
    #       console.log(dealerH.scores())
    #       break

    # dealerH.on 'gameSet', =>
    #   dealerScore  = if dealerH.scores()[0] > dealerH.scores()[1] then dealerH.scores()[0] else dealerH.scores()[1]
    #   playerScore =
    #     if playerH.scores()[1] > 21
    #       playerH.scores()[0]
    #     else if playerH.scores()[1] is 1
    #       playerH.scores()[0]
    #     else playerH.scores()[1]
    #   console.log "dealer #{dealerScore} player #{playerScore}"
    #   if dealerScore is playerScore
    #     alert "draw!"
    #   if dealerScore > playerScore
    #     alert "you lose"
    #   if dealerScore < playerScore
    #     alert "you win"



    #make all the plays required for the dealer and finish the hand

    # @get('dealerHand').on()
