module DHC
  class ReplayService < ::CompositeService
    DEFAULT_DURATION = 7200

    def initialize(duration = DEFAULT_DURATION)
      super()
      @duration = duration
    end

    def run
      Rails.logger.info("Replay(#{@duration}): start")
      start_time = Time.now
      loop do
        time_spent = Time.now - start_time
        break if time_spent > @duration
        super
        Rails.logger.info("Replay(#{@duration}): remaining #{(@duration - time_spent).to_i}")
      end
      Rails.logger.info("Replay(#{@duration}): end")
    end

    private

    def commands
      [
        Pause.new(1),
        # auto on
        ClickImage.new("adventure/auto_off"),
        ClickImage.new("adventure/auto_off"),
        ClickImage.new("boss/ed_auto_off"),
        ClickImage.new("boss/sw_auto_off"),
        Pause.new(0.1),
        # rewards
        ClickImage.new("replay/rewards"),
        Pause.new(0.1),
        ClickImage.new("replay/more_rewards"),
        Pause.new(0.1),
        # events
        ClickImage.new("replay/events"),
        Pause.new(0.1),
        # replay
        ClickImage.new("replay/replay"),
        Pause.new(0.1),
        # skip
        ClickImage.new("replay/skip"),
        Pause.new(0.1),
        # spend gems
        ClickImage.new("replay/spend_gems"),
        Pause.new(0.1),
        ClickImage.new("replay/shop_energy"),
        Pause.new(0.1),
        ClickImage.new("replay/confirm_purchase"),
        Pause.new(0.1),
        # level up
        ClickImage.new("replay/level_up"),
        Pause.new(0.1),
        # connection failed
        ClickImage.new("replay/connection_failed"),
        Pause.new(0.1)
      ]
    end
  end
end
