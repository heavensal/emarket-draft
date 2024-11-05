module Stripe
  class StripeProductService
    def initialize(product)
      @product = product
    end

    def create(product)
      stripe_product = Stripe::Product.create({
        name: product.name,
        default_price_data: {
          unit_amount: (product.price * 100).to_i,
          currency: 'eur'
        },
        images: product.photos.attached? ? [product.photos.first.url] : []
      })
      return stripe_product
    end

    def update(product)
      Stripe::Product.update(product.stripe_product_id, {
        name: product.name,
        images: product.photos.attached? ? [product.photos.first.url] : []
      })
    end

    def update_price(product)
      stripe_price = Stripe::Price.create({
                        currency: 'eur',
                        unit_amount: (product.price * 100).to_i,
                        product: product.stripe_product_id,
                      })
      Stripe::Product.update(product.stripe_product_id, default_price: stripe_price.id)
      return stripe_price
    end
  end
end
