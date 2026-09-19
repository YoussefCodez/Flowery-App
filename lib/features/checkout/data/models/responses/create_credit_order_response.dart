import 'package:flowery/features/checkout/domain/entities/credit_order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_credit_order_response.g.dart';

CreateCreditOrderResponse createCreditOrderResponseFromJson(String str) => CreateCreditOrderResponse.fromJson(json.decode(str));

String createCreditOrderResponseToJson(CreateCreditOrderResponse data) => json.encode(data.toJson());

@JsonSerializable()
class CreateCreditOrderResponse {
    @JsonKey(name: "message")
    String? message;
    @JsonKey(name: "session")
    Session? session;

    CreateCreditOrderResponse({
        this.message,
        this.session,
    });

    factory CreateCreditOrderResponse.fromJson(Map<String, dynamic> json) => _$CreateCreditOrderResponseFromJson(json);

    Map<String, dynamic> toJson() => _$CreateCreditOrderResponseToJson(this);
}

@JsonSerializable()
class Session {
    @JsonKey(name: "id")
    String? id;
    @JsonKey(name: "object")
    String? object;
    @JsonKey(name: "adaptive_pricing")
    dynamic adaptivePricing;
    @JsonKey(name: "after_expiration")
    dynamic afterExpiration;
    @JsonKey(name: "allow_promotion_codes")
    dynamic allowPromotionCodes;
    @JsonKey(name: "amount_subtotal")
    int? amountSubtotal;
    @JsonKey(name: "amount_total")
    int? amountTotal;
    @JsonKey(name: "automatic_tax")
    dynamic automaticTax;
    @JsonKey(name: "billing_address_collection")
    dynamic billingAddressCollection;
    @JsonKey(name: "branding_settings")
    dynamic brandingSettings;
    @JsonKey(name: "cancel_url")
    String? cancelUrl;
    @JsonKey(name: "client_reference_id")
    String? clientReferenceId;
    @JsonKey(name: "client_secret")
    dynamic clientSecret;
    @JsonKey(name: "collected_information")
    dynamic collectedInformation;
    @JsonKey(name: "consent")
    dynamic consent;
    @JsonKey(name: "consent_collection")
    dynamic consentCollection;
    @JsonKey(name: "created")
    int? created;
    @JsonKey(name: "currency")
    String? currency;
    @JsonKey(name: "currency_conversion")
    dynamic currencyConversion;
    @JsonKey(name: "custom_fields")
    List<dynamic>? customFields;
    @JsonKey(name: "custom_text")
    dynamic customText;
    @JsonKey(name: "customer")
    dynamic customer;
    @JsonKey(name: "customer_account")
    dynamic customerAccount;
    @JsonKey(name: "customer_creation")
    String? customerCreation;
    @JsonKey(name: "customer_details")
    dynamic customerDetails;
    @JsonKey(name: "customer_email")
    String? customerEmail;
    @JsonKey(name: "discounts")
    List<dynamic>? discounts;
    @JsonKey(name: "expires_at")
    int? expiresAt;
    @JsonKey(name: "integration_identifier")
    dynamic integrationIdentifier;
    @JsonKey(name: "invoice")
    dynamic invoice;
    @JsonKey(name: "invoice_creation")
    dynamic invoiceCreation;
    @JsonKey(name: "livemode")
    bool? livemode;
    @JsonKey(name: "locale")
    dynamic locale;
    @JsonKey(name: "managed_payments")
    dynamic managedPayments;
    @JsonKey(name: "metadata")
    dynamic metadata;
    @JsonKey(name: "mode")
    String? mode;
    @JsonKey(name: "origin_context")
    dynamic originContext;
    @JsonKey(name: "payment_intent")
    dynamic paymentIntent;
    @JsonKey(name: "payment_link")
    dynamic paymentLink;
    @JsonKey(name: "payment_method_collection")
    String? paymentMethodCollection;
    @JsonKey(name: "payment_method_configuration_details")
    dynamic paymentMethodConfigurationDetails;
    @JsonKey(name: "payment_method_options")
    dynamic paymentMethodOptions;
    @JsonKey(name: "payment_method_types")
    List<String>? paymentMethodTypes;
    @JsonKey(name: "payment_status")
    String? paymentStatus;
    @JsonKey(name: "permissions")
    dynamic permissions;
    @JsonKey(name: "phone_number_collection")
    dynamic phoneNumberCollection;
    @JsonKey(name: "recovered_from")
    dynamic recoveredFrom;
    @JsonKey(name: "saved_payment_method_options")
    dynamic savedPaymentMethodOptions;
    @JsonKey(name: "setup_intent")
    dynamic setupIntent;
    @JsonKey(name: "shipping_address_collection")
    dynamic shippingAddressCollection;
    @JsonKey(name: "shipping_cost")
    dynamic shippingCost;
    @JsonKey(name: "shipping_details")
    dynamic shippingDetails;
    @JsonKey(name: "shipping_options")
    List<dynamic>? shippingOptions;
    @JsonKey(name: "status")
    String? status;
    @JsonKey(name: "submit_type")
    dynamic submitType;
    @JsonKey(name: "subscription")
    dynamic subscription;
    @JsonKey(name: "success_url")
    String? successUrl;
    @JsonKey(name: "total_details")
    dynamic totalDetails;
    @JsonKey(name: "ui_mode")
    String? uiMode;
    @JsonKey(name: "url")
    String? url;
    @JsonKey(name: "wallet_options")
    dynamic walletOptions;

    Session({
        this.id,
        this.object,
        this.adaptivePricing,
        this.afterExpiration,
        this.allowPromotionCodes,
        this.amountSubtotal,
        this.amountTotal,
        this.automaticTax,
        this.billingAddressCollection,
        this.brandingSettings,
        this.cancelUrl,
        this.clientReferenceId,
        this.clientSecret,
        this.collectedInformation,
        this.consent,
        this.consentCollection,
        this.created,
        this.currency,
        this.currencyConversion,
        this.customFields,
        this.customText,
        this.customer,
        this.customerAccount,
        this.customerCreation,
        this.customerDetails,
        this.customerEmail,
        this.discounts,
        this.expiresAt,
        this.integrationIdentifier,
        this.invoice,
        this.invoiceCreation,
        this.livemode,
        this.locale,
        this.managedPayments,
        this.metadata,
        this.mode,
        this.originContext,
        this.paymentIntent,
        this.paymentLink,
        this.paymentMethodCollection,
        this.paymentMethodConfigurationDetails,
        this.paymentMethodOptions,
        this.paymentMethodTypes,
        this.paymentStatus,
        this.permissions,
        this.phoneNumberCollection,
        this.recoveredFrom,
        this.savedPaymentMethodOptions,
        this.setupIntent,
        this.shippingAddressCollection,
        this.shippingCost,
        this.shippingDetails,
        this.shippingOptions,
        this.status,
        this.submitType,
        this.subscription,
        this.successUrl,
        this.totalDetails,
        this.uiMode,
        this.url,
        this.walletOptions,
    });

    factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

    Map<String, dynamic> toJson() => _$SessionToJson(this);

    CreditOrderEntity toDomain ()=> CreditOrderEntity(url: url);
}
