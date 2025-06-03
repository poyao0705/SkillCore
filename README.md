# SkillCore
## IDE Run Guide
### MacOS Terminal
1. iOS
- **Open Simulator:** `open -a simulator`
- **Find the device:** `flutter devices`
- Find the mobile simulator serial number
- **Run project:** `flutter run -d <serial_number>`

2. MacOS
- **Run the project:** `flutter run`
- Follow the instruction and choose desktop (MacOS)

## Technical Setup
### local Dev Environment
1. **Create an asset folder:** `./skillcore/assets`
2. **Create an env file:** `./skillcore/assets/env.json`
3. **Setup 4 Parameters:**
    - Supabase setup and Google Signin guide please find Supabase documentation: [Getting started with Flutter authentication](https://supabase.com/blog/flutter-authentication)
    ```json
    {
        "SUPABASE_URL": "...",
        "SUPABASE_ANON_KEY": "...",
        "GOOGLE_WEB_CLIENT_ID": "...",
        "GOOGLE_IOS_CLIENT_ID": "..."
    }
    ```