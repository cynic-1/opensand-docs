---
title: "LunaTranslator"
source: "https://opensand.ai/en/docs/apps/luna-translator"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.137Z"
---
# LunaTranslator - Open-source GalGame Translator

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Chat Settings Options**

In the OpenSand console's System Settings -> Chat Settings, you can add the
following shortcut option for one-click population into LunaTranslator on the
Token Management page:

    ```json
    { "LunaTranslator": "lunatranslator://llmapi/base64?data={cheryConfig}" }
    ```

LunaTranslator is an open-source and free visual novel (GalGame) translator,
dedicated to providing a native-level visual novel gaming experience.

- Project Address: [https://github.com/HIllya51/LunaTranslator](https://github.com/HIllya51/LunaTranslator)
- Project Documentation: [https://docs.lunatranslator.org](https://docs.lunatranslator.org/en/README.html)

## Feature Support

- **HOOK** Primarily uses HOOK to extract game text, adapting to almost all common and niche visual novels.

- **In-game Translation** Some games can also have translations directly embedded in-game for an immersive experience.

- **HOOK Emulator** For most games on NS/PSP/PSV/PS2, HOOK emulator is supported to directly read game text.

- **OCR** Built-in high-precision OCR models, and supports many other online & offline OCR engines for flexible reading of any text.

- **Rich Translation Interfaces** Supports almost all translation engines, including large language model translation, offline translation, etc.

- **Language Learning** Supports Japanese word segmentation and kana furigana, AnkiConnect, and Yomitan plugin.

- **Speech Synthesis** Supports a large number of online & offline speech synthesis engines.

- **Speech Recognition** On Windows 10 and Windows 11, Windows Speech Recognition can be used.

## Installation

Download and install from [LunaTranslator Documentation - Download & Launch & Update](https://docs.lunatranslator.org/en/README.html)

## Integrating OpenSand into LunaTranslator

LunaTranslator can connect to OpenSand through its custom LLM API settings.

### One-Click Configuration

1.  In the OpenSand console's `System Settings` -> `Chat Settings`, add the following shortcut option:

    ```json
    { "LunaTranslator": "lunatranslator://llmapi/base64?data={cheryConfig}" }
    ```

    ![add_config](../../../pictures/apps/luna_translator/add_config.png)

2.  In the **`OpenSand`** -> `Console` -> `Token Management` tab, select the token to be used in LunaTranslator, click the dropdown option next to the chat button, select `LunaTranslator`, and it will jump to LunaTranslator and automatically configure the API address and API Key.

    ![跳转到 LunaTranslator](../../../pictures/apps/luna_translator/jump_to_app.png)

3.  In **`LunaTranslator`** -> `Settings` -> `Translation Settings` -> `Large Models`, a new large model interface configuration will appear; click Edit.

    ![设置api](../../../pictures/apps/luna_translator/api_setting.png)

4.  Click the refresh button next to the **model** dropdown box to get the OpenSand platform's model list, select or enter the model name, then click OK to save.

    ![设置模型](../../../pictures/apps/luna_translator/setting_model.png)

5.  Check if the toggle button next to the **new_api** large model interface configuration is open; if not enabled, enable the interface to start using it.

    ![开启配置](../../../pictures/apps/luna_translator/open_config.png)

### Manual Configuration

1.  In the **`OpenSand`** -> `Console` -> `Token Management` tab, obtain the API Key.

    ![获取 API Key](../../../pictures/apps/luna_translator/copy_api_key.png)

2.  In **`LunaTranslator`** -> `Settings` - `Translation Settings` -> `Large Models`, select Add.

    ![添加 API](../../../pictures/apps/luna_translator/add_api.png)

3.  Copy the **Large Model General Interface** template and add a new interface.

    ![添加 API2](../../../pictures/apps/luna_translator/add_api_2.png)

4.  In the **newly added interface**, fill in the corresponding API address and API Key.

    ![设置 API1](../../../pictures/apps/luna_translator/setting_api.png)

    ![设置 API2](../../../pictures/apps/luna_translator/setting_api2.png)

5.  Click the refresh button next to the **model** dropdown box to get the OpenSand platform's model list, select or enter the model name, then click OK to save.

    ![设置 API3](../../../pictures/apps/luna_translator/setting_api3.png)

6.  Click the toggle button next to **OpenSand** to enable the interface and start using it.

    ![打开API](../../../pictures/apps/luna_translator/open_api.png)

For more usage methods, please refer to the LunaTranslator official documentation: [LunaTranslator Documentation - Large Model Translation Interface](https://docs.lunatranslator.org/en/guochandamoxing.html)
