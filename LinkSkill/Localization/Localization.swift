//
//  Localization.swift
//  LinkSkill
//
//  Created by Rohit SIngh Dhakad on 08/05/26.
//

import Foundation
import UIKit

// MARK: - Localization Manager

enum L10n {
    
    // MARK: - General
    
    static let appName = tr("app_name")
    static let welcomeText = tr("welcome_text")
    static let welcomeToLinkskill = tr("welcome_to_linkskill")
    
    static let login = tr("login")
    static let register = tr("register")
    static let signIn = tr("sign_in")
    static let signUp = tr("sign_up")
    static let submit = tr("submit")
    static let save = tr("save")
    static let done = tr("done")
    static let apply = tr("apply")
    static let accept = tr("accept")
    static let award = tr("award")
    static let complete = tr("complete")
    static let logout = tr("logout")
    static let ok = tr("ok")
    static let success = tr("success")
    static let fail = tr("fail")
    
    // MARK: - Auth
    
    static let email = tr("email")
    static let password = tr("password")
    static let forgotPassword = tr("forgot_password")
    static let forgotPasswordOne = tr("forgot_password_one")
    
    static let employee = tr("i_m_a_employee")
    static let employer = tr("i_m_a_employer")
    
    static let dontHaveAccount = tr("don_t_have_an_account_register_here")
    
    static let userName = tr("user_name")
    static let username = tr("username")
    static let mobileNumber = tr("mobile_number")
    static let address = tr("address")
    static let city = tr("city")
    static let country = tr("country")
    static let state = tr("state")
    static let zipCode = tr("zip_code")
    
    static let enterYourName = tr("enter_your_name")
    static let enterYourEmail = tr("enter_your_email")
    static let enterYourPassword = tr("enter_your_password")
    static let enterYourAddress = tr("enter_your_address")
    static let enterYourMobile = tr("enter_your_mobile")
    static let enterYourCountry = tr("enter_your_country")
    static let enterYourState = tr("enter_your_state")
    static let enterYourCity = tr("enter_your_city")
    static let enterYourZip = tr("enter_your_zip")
    
    static let mobileVerification = tr("mobile_verification")
    static let enterFullOTP = tr("enter_full_otp")
    
    // MARK: - Home
    
    static let home = tr("home")
    static let chat = tr("chat")
    static let profile = tr("profile")
    static let more = tr("more")
    static let you_have = tr("you_have")
    
    
    static let alredyHaveBid = tr("you_have_already_bid_on_this_job")
    
    static let active = tr("active")
    static let completed = tr("completed")
    static let open = tr("open")
    
    // MARK: - Job
    
    static let postAJob = tr("post_a_job")
    static let jobDetails = tr("job_details")
    static let serviceType = tr("service_type")
    static let descriptionServices = tr("description_services")
    static let serviceRate = tr("service_rate")
    static let skillsRequired = tr("skills_required")
    static let selectSkills = tr("select_skills")
    
    static let enterServiceType = tr("enter_service_type")
    static let enterJobDetails = tr("enter_job_details")
    static let enterServiceRate = tr("enter_service_rate")
    static let enterPrice = tr("enter_price")
    
    static let price = tr("price")
    static let currency = tr("currency")
    
    static let proposals = tr("proposals")
    static let applyNow = tr("apply_now_if_you_have_nthe_requier_skill")
    static let applyForJob = tr("apply_for_job")
    static let describeYourProposal = tr("describe_your_proposal")
    static let bidAmount = tr("bid_amount")
    
    static let enterBidAmount = tr("enter_bid_amount")
    static let enterProposal = tr("enter_proposal")
    static let enterDeliveryDays = tr("enter_delivery_days")
    
    static let noJobsAvailable = tr("no_jobs_available")
    static let noBidAvailable = tr("no_bid_available")
    
    static let whta_is_milestone = tr("whta_is_milestone")
    static let create_milestone = tr("create_milestone")
    static let mark_as_complete = tr("mark_as_complete")
    static let place_a_bid_on_this_service = tr("place_a_bid_on_this_service")
    static let days_s = tr("days_s")
    static let this_service_will_be_delivered_in = tr("this_service_will_be_delivered_in")
    static let service_history = tr("service_history")
    static let accepted = tr("accepted")
    static let select_service_nyou_provide = tr("select_service_nyou_provide")
    static let usd_in_your_wallet_n_nplease_enter_amount_you_want_to_transfer_in_your_account = tr("usd_in_your_wallet_n_nplease_enter_amount_you_want_to_transfer_in_your_account")
    static let in_ = tr("in")
    
    static let pay_linkskill_securely = tr("pay_linkskill_securely_with_the_milestone_payment_system_it_provides_protection_for_both_clients_and_freelancers_by_allowing_equal_control_over_payments_for_projects_n_nhere_s_how_it_works_n_nwhen_a_freelancer_and_a_client_start_working_together_they_will_agree_on_a_set_of_milestones_or_tasks_for_the_project_these_milestones_might_include_things_like_completing_a_certain_number_of_pages_or_reaching_a_certain_stage_in_the_design_process")
    
    // MARK: - Wallet
    
    static let myWallet = tr("my_wallet")
    static let totalAmount = tr("total_amount")
    static let withdrawl = tr("withdrawl")
    
    // MARK: - Bank
    
    static let addBankDetail = tr("add_bank_detail")
    static let bankName = tr("bank_name")
    static let accountHolderName = tr("account_holder_name")
    static let accountNumber = tr("account_number")
    static let ifscCode = tr("ifsc_code")
    
    static let enterBankName = tr("enter_bank_name")
    static let enterHolderName = tr("enter_holder_name")
    static let enterAccountNumber = tr("enter_account_number")
    static let enterIfscCode = tr("enter_ifsc_code")
    
    // MARK: - Rating
    
    static let reviewRating = tr("review_rating")
    static let comments = tr("comments")
    static let please_leave_your_feedback_and_submit_your_rating_for_this_seller = tr("please_leave_your_feedback_and_submit_your_rating_for_this_seller")
    static let pleaseSelectRating = tr("please_select_rating")
    static let pleaseEnterComments = tr("please_enter_comments")
    static let ratingSubmittedSuccessfully = tr("rating_submitted_successfully")
    
    // MARK: - Contact
    
    static let contactUs = tr("contact_us")
    static let subject = tr("subject")
    static let message = tr("message")
    
    static let enterSubject = tr("enter_subject")
    static let enterYourMessage = tr("enter_your_message")
    static let sendMessage = tr("send_message")
    
    static let pleaseEnterSubject = tr("please_enter_subject")
    static let pleaseEnterMessage = tr("please_enter_message")
    
    // MARK: - Subscription
    
    static let subscribe = tr("subscribe")
    static let mySubscription = tr("my_subscription")
    
    // MARK: - Reviews
    
    static let myReviews = tr("my_reviews")
    static let noReviewFound = tr("no_review_found")
    
    // MARK: - Skills
    
    static let editSkills = tr("edit_skills")
    
    // MARK: - Settings
    
    static let language = tr("language")
    static let english = tr("english")
    static let portuguese = tr("portuguese")
    static let spanish = tr("spanish")
    static let saveAndRestart = tr("save_and_restart")
    
    static let privacyPolicy = tr("privacy_policy")
    static let termsConditions = tr("tearms_conditions")
    
    // MARK: - Errors
    
    static let serverError = tr("str_fail")
    static let connectionError = tr("connection_error")
    
    // MARK: - Media
    
    static let mediaMode = tr("media_mode")
    static let image = tr("image")
    static let file = tr("file")
    static let video = tr("video")
    static let audio = tr("audio")
    static let select = tr("select")
    
    static let loadURL = tr("load_url")
    static let viewVideo = tr("view_video")
    static let playAudio = tr("play_audio")
    static let imagePreview = tr("imagr_view")
    static let imageNotLoading = tr("not_image_opening")
    
    // MARK: - Private
    
    private static func tr(_ key: String) -> String {
        NSLocalizedString(
            key,
            tableName: "Localizable",
            bundle: .main,
            value: key,
            comment: ""
        )
    }
}

// MARK: - UILabel

extension UILabel {
    
    func setLocalizedText(_ text: String) {
        self.text = text
    }
}

// MARK: - UIButton

extension UIButton {
    
    func setLocalizedTitle(_ title: String,
                           for state: UIControl.State = .normal) {
        self.setTitle(title, for: state)
    }
}

// MARK: - UITextField

extension UITextField {
    
    func setLocalizedPlaceholder(_ text: String) {
        self.placeholder = text
    }
}

// MARK: - UITextView

extension UITextView {
    
    func setLocalizedText(_ text: String) {
        self.text = text
    }
}
