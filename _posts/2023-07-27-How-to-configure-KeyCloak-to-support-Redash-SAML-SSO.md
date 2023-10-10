---
layout: post
title: "How to configure KeyCloak to support Redash SAML SSO?"
date: 2023-07-27 10:38:57
update: 2023-10-10 19:00:00
location: Saigon
tags:
- Redash
- SAML
- Keycloak
categories: Redash
seo_description: How to configure KeyCloak to support Redash SAML SSO?
seo_image:
comments: true
---

# I. KeyCloak Configuration
## Step 1: Create a new realm
First of all, let start with definition of reaml, it’s what I got from [KeyCloak official website](https://www.keycloak.org/docs/latest/server_admin/).


Realms
A realm manages a set of users, credentials, roles, and groups. A user belongs to and logs into a realm. Realms are isolated from one another and can only manage and authenticate the users that they control.

Realms (Tiếng Việt): cõi, địa hạt, vương quốc, vùng
Một realm quản lý một tập hợp user, thông tin xác thực - credential, role và group. Một user sẽ thuộc một realm, một realm sẽ có nhiều user, user sẽ đăng nhập vào reaml mà nó thuộc về. Một server KeyCloak tạo được rất nhiều realm, và chúng bị cô lập với nhau. Những realm này chỉ có thể quản lý và cho đăng nhập những user mà chúng quản lý.

As the definition of realm , this step is only used for testing only, normaly, if your **KeyCloak** did create a realm, you can skip this step and go to step 2.
{% include image.html url="/image/posts/2023-07-27-How-to-configure-KeyCloak-to-support-Redash-SAML-SSO/1.png" description="[1] Add a new realm." %}

## Step 2: Create new reaml’s client & configure it

{% include image.html url="/image/posts/2023-07-27-How-to-configure-KeyCloak-to-support-Redash-SAML-SSO/2.png" description="[2] Create realm's client" %}

In new client form, I would like to input the following parameters, then submit.

- Client ID: `redash`
- Client Protocol: `saml`
- Client SAML Endpoint: ignored this field.

After that, edit that new client named `redash`

{% include image.html url="/image/posts/2023-07-27-How-to-configure-KeyCloak-to-support-Redash-SAML-SSO/3.png" description="[3] Edit Redash client" %}
Client ID: redash

- Name: `Redash`
- Description: `empty`
- Enabled: `on`
- Always Display in Console: `off`
- Consent Required: `off`
- Login Theme: `keycloak`
- Client Protocol: `saml`
- Include AuthnStatement: `on`
- Include OneTimeUse Condition: `off`
- Force Artifact Binding: `off`
- Sign Documents: `off`
- Sign Assertions: `on`
- Signature Algorithm: `RSA_SHA256`
- SAML Signature Key Name: `KEY_ID`
- Canonicalization Method: `EXCLUSIVE_WITH_COMMENTS`
- Encrypt Assertions: `off`
- Client Signature Required: `off`
- Force POST Binding: `off`
- Front Channel Logout: `off`
- Force Name ID Format: `off`
- Allow ECP Flow: `off`
- Name ID Format: `email`
- Root URL: `ignored`
- Valid Redirect URIs: `https://redash.local-domain.com/*`
- Base URL: `https://redash.local-domain.com/`
- Master SAML Processing URL: `https://redash.local-domain.com/saml/callback?org_slug=default`
- IDP Initiated SSO URL Name: `ignored`
- Logo URL: `ignored`
- Policy URL: `ignored`
- Terms of service URL: `ignored`
- IDP Initiated SSO Relay State: `ignored`

{% include image.html url="/image/posts/2023-07-27-How-to-configure-KeyCloak-to-support-Redash-SAML-SSO/4.png" description="[4] Client settings" %}
## Step 3: Configure client’s mappers
In the saml response that Redash expected to received, it requires

- First Name (original), this attibute name is `FirstName`
- Last Name (original), this attribute name is `LastName`

However, in the **KeyCloak**, the attribute names are different from what **Redash** expected, as a consequence, we need to configure client’s mappers
For first name and last name, use `Add Builtin` feature.

{% include image.html url="/image/posts/2023-07-27-How-to-configure-KeyCloak-to-support-Redash-SAML-SSO/5.png" description="[5] First name and last name mappers" %}

{% include image.html url="/image/posts/2023-07-27-How-to-configure-KeyCloak-to-support-Redash-SAML-SSO/6.png" description="[6] First name and last name mapper detail" %}

- X500 Surname
  - Property: `lastName`
  - Friendly Name: `LastName`
  - SAML Attribute Name: `LastName`

- X500 GivenName
  - Property: `firstName`
  - Friendly Name: `FirstName`
  - SAML Attribute Name: `FirstName`

# II. Redash SAML Configuration
After login using admin credential, go to Settings → General → Saml

- SAML Enabled: `Enable (Dynamic)`
- SAML Metadata URL: `https://keyclock.local-domain.com/apps/keycloak/realms/{REALM_NAME}/protocol/saml/descriptor`
- SAML Entity ID: `redash`
- SAML NameID Format: `urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress`

{% include image.html url="/image/posts/2023-07-27-How-to-configure-KeyCloak-to-support-Redash-SAML-SSO/7.png" description="[7] Redash’s SAML configuration" %}

You are done! Enjoy!

# III Reference
- [saml] Signature missing for assertion,  rockxsj, 2018, [https://github.com/getredash/redash/issues/2977](https://github.com/getredash/redash/issues/2977)
