class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    @sender.valid?
    @receiver.valid? 
  end

  def execute_transaction
    if sender.balance < amount || valid? == false
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
    if @status == 'pending' && valid?
      sender.balance -= amount
      receiver.balance += amount
      @status = "complete"
    end
  end

  def reverse_transfer
    if @status == 'complete' && valid?
      sender.balance += amount
      receiver.balance -= amount
      @status = "reversed"
    end
  end
end
