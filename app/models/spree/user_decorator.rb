Spree::User.class_eval do
  has_many :likes, :class_name => "Dish::Like", foreign_key: 'user_id'
  has_many :like_products, :through => :likes, :class_name => "Spree::Product"
  has_many :surveys, :class_name => "Survey::Survey", foreign_key: 'user_id'
  has_many :shipments, :class_name => "Spree::Shipment", foreign_key: 'user_id'

  scope :deliverers, -> { Spree::User.all.to_a.select{ |u| u.has_spree_role?('deliverer') } }

  accepts_nested_attributes_for :likes,
    :reject_if => :all_blank,
    :allow_destroy => true
  accepts_nested_attributes_for :like_products

  accepts_nested_attributes_for :shipments,
    :reject_if => :all_blank,
    :allow_destroy => true

  def change_password(password_params)
    if self.valid_password?(password_params[:old])
      self.password = password_params[:new]
      save!
      return true
    else
      return false
    end
  end

  def approved_comments
    Dish::Comment.where(user_id: self.id, status: 1)
  end

  def update_information_with_email_change(user_information_params)
    if (self.update(user_information_params.except(:email)) &&
        self.update(change_email: user_information_params[:email],
                    email_change_token: SecureRandom.urlsafe_base64.to_s))
      return true
    else
      return false
    end
  end

  def confirm_email_change
    self.email = self.change_email
    self.change_email = nil
    self.email_change_token = nil
    save!
  end

  def add_fund(amount)
    self.balance += amount*1.1
  end

  def set_role(role)
    self.spree_roles = Spree::Role.where(id: role)
  end

  
end
