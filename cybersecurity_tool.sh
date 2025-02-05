#!/bin/bash

# Цвета
yellow="\e[38;5;226m"
blue="\e[38;5;39m"
red="\e[38;5;196m"
green="\e[38;5;46m"
orange="\e[38;5;202m"
reset="\e[0m"

# Файл для хранения пароля
PASSWORD_FILE="password.txt"

# Проверка наличия файла с паролем
if [ ! -f "$PASSWORD_FILE" ]; then
    echo "Файл с паролем не найден. Создайте файл '$PASSWORD_FILE' и сохраните в нем пароль."
    exit 1
fi

# Чтение пароля из файла
CORRECT_PASSWORD=$(cat "$PASSWORD_FILE")

# Очистка экрана при запуске
clear

# Первый ASCII-арт (приветственный)
show_welcome_art() {
    # Цвет для приветственного логотипа
    WELCOME_COLOR="\e[38;5;202m" # Оранжевый

    # ASCII-арт (приветственный)
    ascii=(
"        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣲⣶⠒⠷⠶⠤⠴⠦⠤⠤⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀"
        "⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣴⣶⠚⠛⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠴⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⢌⣛⠶⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠠⢚⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠱⡄⠙⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀       ⠀⢀⡤⠖⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣀⠀⣀⣤⣧⠔⠛⠓⠲⠤⢄⣀⠀⠀⠀⠀⠀⠀ ⠀⠀"
        "⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⢐⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣤⣄⣠⣤⣴⣾⣿⣿⣾⡗⠀⢀⣀⢤⠐⠠⠤⣉⠓⠦⣄⠀⠀⠀⠀"
        "⠀⠀⠀⠀⠀⠀⠀⠀        ⢀⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒⠒⠶⠶⢾⣿⡿⠛⢻⣻⠛⢻⣿⣿⠟⣋⣺⣿⠏⠀⠴⠿⠹⠋⠀⠀⠀⠀⠈⠀⠨⠳⣄⠀⠀"
        "⠀⠀⠀⠀⠀        ⠀⠀⢐⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⠤⠄⠐⢾⣿⣝⠤⣀⢀⡠⣱⣿⣿⣿⣿⠿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠀"
        "⠀⠀⠀⠀⠀        ⠀⢠⡂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢉⣛⣺⣿⣾⣛⣽⣿⡟⠁⠀⠀⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀"
        "⠀⠀⠀⠀        ⠀⠐⡟⠀⠀⠀⠀⡠⠖⠀⠀⠀⢀⡴⠃⠀⠀⠀⠀⠀⠀⡈⠉⢉⡽⠿⢛⡿⢛⠯⠭⣒⣚⣩⣭⣭⣤⡤⠭⠭⢭⣥⣀⣉⣑⣒⢵⡀⠀⠀⢸⡇"
        "⠀⠀⠀⠀        ⠀⣰⠃⠀⢀⡔⠋⠀⠀⠀⣠⡴⠋⠀⠀⠀⠀⣠⣤⡴⠋⠀⠀⠀⠀⠀⠾⢶⣾⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠳⡀⠀⣸⠃"
        "⠀⠀⠀        ⠀⢰⠟⢀⣴⠏⠀⡀⢀⣴⡿⠋⠀⠀⠀⢀⡴⠟⠋⠁⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣇⠔⠁⠀"
        "⠀⠀⠀        ⠀⣞⣴⣿⠃⢠⣾⣴⣿⠋⠀⠀⠀⠀⠐⠋⠀⠀⠀⠀⠀⢐⣚⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠋⠁⠀⠀⠀"
        "⠀⠀        ⠀⣸⣿⣿⣧⣶⣿⣿⣿⠗⠁⠀⡠⠂⠀⢀⠀⠀⠀⠀⠂⢉⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⡟⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀        ⢀⠼⢻⣿⣿⣿⣿⣿⣿⠁⢀⣴⠏⢀⣠⠞⠁⢀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠱⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀        ⠀⣠⣿⣿⣿⣿⣿⣿⣧⣾⡿⣡⣾⣿⠃⣠⡾⠁⠀⣀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠂⠀⢻⣍⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀        ⠈⣽⣿⣿⣿⣿⣿⣿⡟⠉⣰⣿⡿⣡⣾⣿⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢻⣶⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀        ⣠⣿⣿⣿⣿⣿⣿⣿⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⣱⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⢸⣾⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "    ⠐⠛⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣿⠏⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣼⡄⠀⣿⣿⡏⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀        ⠀⣾⡿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣴⡿⢋⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀        ⠀⠁⠀⡿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀       ⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀"
        "⠀⠀⠀⠀        ⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀⠀        ⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⣿⣿⣿⢿⡿⠁⣿⠏⠘⢿⣿⣿⣿⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀⠀        ⠀⠀⠀⠿⠋⣿⡿⠋⣸⠟⠁⠀⣾⣿⣿⣿⣿⣿⠟⠁⠈⠀⠀⠹⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠁⠀⠀⠉⠀⠀⠰⠿⣿⣿⠿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀        ⠀⠀⠀⠀⠀⠀⠀⠙⡏⠀⠻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
        "                                                                          "
        "--------------------------------------------------------------------------"
        "                                                                          "
        "                              Admin SALIEVVS                              "
        "                        Powered By : Emerix Studio                        "
    )
    for line in "${ascii[@]}"; do
        echo -e "${WELCOME_COLOR}${line}${reset}"
        sleep 0.01
    done
    clear
    # Выводим приветственный логотип с выбранным цветом
    for line in "${ascii[@]}"; do
        echo -e "${WELCOME_COLOR}${line}\e[0m"
    done
}

# Основной ASCII-арт (основной логотип)
show_main_art() {
    # Цвет для основного логотипа
    MAIN_COLOR="\e[38;5;46m" # Ярко-зеленый

    # ASCII-арт (основной логотип)
    ascii=(
        "                                 ⠀⠀⠀⢀⢾⠋⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⢸⠒⢲⢌⣎⢢⠀⠀⠀           "
        "                                ⠀⠀⡠⠃⠈⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠞⠀⠀⠀⠀⠀⠱⡀⠀            "
        "                                ⠀⠠⠁⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⢤⠔⠲⡖⠀⠀⠀⠐⠒⢤⠀⠀⠀⠀⠀⠱⠀            "
        "                                ⢀⠃⠀⠀⠀⠀⠀⠀⢀⡠⠒⣁⡰⠹⢒⠃⠇⢰⠀⠀⠀⠢⡀⠱⡀⠀⠀⠀⠀⠇            "
        "                                ⠘⠀⠀⠀⠀⠀⢀⣔⠥⡲⠉⠜⢀⣀⡌⠀⡆⢸⣀⠀⠀⠆⠈⢄⠱⡀⠀⠀⠀⢀            "
        "                                ⠀⠀⠀⠀⢀⡴⠋⡑⠠⢡⠎⠀⠀⢸⠀⠀⢠⠋⡄⠀⠰⡇⣾⠈⣢⠱⠀⠀⠀⠘            "
        "                                ⠀⠀⠀⢠⠋⢠⠀⣇⠆⠘⢶⣤⣀⡠⠄⠀⠘⠀⡇⢠⠃⡷⢄⡄⠇⠱⡇⠀⠀⠘            "
        "                                ⠀⠀⣰⠁⠀⠈⣆⣹⠀⠀⠸⣄⣨⡿⠃⠀⠀⢀⡵⣅⣈⠀⠀⣽⠁⠀⢻⠀⠀⠆            "
        "                                ⠀⣰⣿⠀⠀⠀⢹⣾⠀⠀⠀⠈⠁⠀⠀⠀⠀⠈⠀⠩⡟⠲⢦⣵⠀⡄⣸⠀⡜⠀            "
        "                                ⢀⣿⣿⠀⠀⠀⢸⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⠴⠞⠑⣰⢃⢿⡸⠁⠀            "
        "                                ⣸⣿⣿⣇⠀⠀⢸⠣⡀⠀⠀⢀⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⡸⢊⣼⠇⠀⠀            "
        "                                ⣿⣿⣿⡿⠀⠀⢸⡄⡗⢄⠀⠈⠄⣀⣙⡶⠀⠀⠀⠀⠀⢠⠟⡝⡡⡻⢹⠀⠀                        ⠀"
        "                                ⠹⣿⣿⠃⠀⠀⢸⣷⢳⠀⠑⢄⠀⠀⠀⠀⢀⣀⣀⠤⢒⠝⢇⡴⠛⠁⢸⠀⠀                        ⠀"
        "                                ⡄⢸⠃⠀⠀⠀⣿⣿⡌⠀⠀⠀⠈⣉⠽⠵⣿⠃⢀⠔⠁⢸⠋⣀⣠⣤⡼⠀⠀⠀            "
        "                                ⠈⠛⠀⠀⠀⢸⣀⡈⠷⣀⣀⡔⠉⢠⠤⠔⢺⡴⠁⠀⢀⠟⠛⢻⣿⠿⠃⠀⠀⠀            "
        "------------------------------------------------------------------------------------------------------"
        "------------------------------------------------------------------------------------------------------"
        "                                                                                 "
        "                                     Coded By : SALIEVVS                         "
        "                                        V : 1w-SNAPSHOT                          "
        "                                      Team : Emerix Studio                       "
        "                                          Owner : ip3e                           "
        "                        GitHub: https://github.com/SalievvsEmerix/Sova-Tools     "
    )
    for line in "${ascii[@]}"; do
        echo -e "${MAIN_COLOR}${line}${reset}"
        sleep 0.01
    done
    clear
    # Выводим основной логотип с выбранным цветом
    for line in "${ascii[@]}"; do
        echo -e "${MAIN_COLOR}${line}\e[0m"
    done
}

# Функция для проверки пароля
check_password() {
    show_welcome_art
    echo -e "\e[38;5;202mВведите пароль для доступа к программе:\e[0m"
    read -s password
    echo
    if [[ "$password" == "$CORRECT_PASSWORD" ]]; then
        clear
        return 0
    else
        echo -e "\e[38;5;196mНеверный пароль. Программа завершает работу.\e[0m"
        exit 1
    fi
}

# Функция для отображения главного меню
show_menu() {
    show_main_art
    echo -e "${yellow}┌──────────────────────────────────────────────────────────────────────────────────────────────────────┐${reset}"
    echo -e "${yellow}│${blue} [01] Сканирование уязвимостей сайта ${red}[Образовательное]${blue}                  [11] Домашнее задание         ${yellow}│${reset}"
    echo -e "${yellow}│${blue} [02] Анализ сети                                    [12] Выполнение скриптов ${red}[Образовательное]       ${blue}${yellow}│${reset}"
    echo -e "${yellow}│${blue} [03] Поиск админ-панелей ${orange}[На Разработке]${blue}            [13] Проверка доступности сайта                  ${yellow}│${reset}"
    echo -e "${yellow}│${blue} [04] Генерация dork-запросов                        [14] Обучение по безопасности                    ${yellow}│${reset}"
    echo -e "${yellow}│${blue} [05] Поиск баз данных                               [15] Удалено (недоступно)                        ${yellow}│${reset}"
    echo -e "${yellow}│${blue} [06] Обход защиты админ-панели V1 ${green}[Исправлено]${blue}      [16] Массовая проверка сайтов                    ${yellow}│${reset}"
    echo -e "${yellow}│${blue} [07] Информация о телефонном номере                 [17] Анализ Wi-Fi сетей                          ${yellow}│${reset}"
    echo -e "${yellow}│${blue} [08] Анализ логов DOFOX ${red}[Образовательное]${blue}           [18] Автоматический анализ уязвимостей           ${yellow}│${reset}"
    echo -e "${yellow}│${blue} [09] Автоматическая генерация dork-запросов         [19] Обход защиты админ-панели V2 ${green}[Исправлено]   ${blue}${yellow}│${reset}"
    echo -e "${yellow}│${blue} [10] Анализ безопасности камер                      [20] Дополнительно                               ${yellow}│${reset}"
    echo -e "${yellow}└──────────────────────────────────────────────────────────────────────────────────────────────────────┘${reset}"
}

in_dev() {
    echo -e "${yelloy}Это функция на разработке${reset}"
} 

# Функция для выбора опции
main_menu() {
    while true; do
        show_menu
        read -p "Выберите опцию (1-20): " choice

        case $choice in
            1) scan_website ;;
            2) network_analysis ;;
            3) in_dev ;;
            4) generate_dorks ;;
            5) database_finder ;;
            6) admin_bypasser_v1 ;;
            7) phone_info ;;
            8) dofox_logs ;;
            9) auto_dork ;;
            10) camera_security ;;
            11) homework ;;
            12) script_executor ;;
            13) ping_site ;;
            14) security_training ;;
            15) echo "Эта функция удалена." ;;
            16) mass_scan ;;
            17) wifi_analysis ;;
            18) auto_exploit ;;
            19) admin_bypasser_v2 ;;
            20) more_options ;;
            *) echo -e "${red}Неверный выбор. Попробуйте снова.${reset}" ;;
        esac

        echo "Нажмите Enter, чтобы вернуться в главное меню."
        read -p ""
        clear
    done
}

# Функции для каждой опции
scan_website() {
    read -p "Введите URL сайта для сканирования: " url
    echo -e "${blue}Начинаю сканирование сайта $url...${reset}"
    nikto -h "$url"
    echo -e "${blue}Сканирование завершено.${reset}"
}

network_analysis() {
    echo -e "${blue}Анализ сети (образовательные цели)...${reset}"
    echo "Эта функция предназначена для анализа вашей собственной сети."
    read -p "Введите IP-адрес для анализа: " ip
    nmap -sP "$ip"
}

# Функция для поиска админ-панелей
admin_finder() {
    # Очистка экрана
    clear

    # Отображение ASCII-арта
    show_admin_art

    # Ввод URL сайта
    echo -e "${blue}Поиск админ-панелей...${reset}"
    read -p "Введите URL сайта (например, http://example.com): " url

    # Проверка, что URL не пустой
    if [[ -z "$url" ]]; then
        echo -e "${red}Ошибка: URL не может быть пустым.${reset}"
        echo "Нажмите Enter, чтобы вернуться в главное меню."
        read -p ""
        return
    fi

    # Список стандартных путей для админ-панелей
    admin_paths=(
        "/admin"
        "/login"
        "/admin/login"
        "/dashboard"
        "/wp-admin"
        "/administrator"
        "/control"
        "/manager"
        "/panel"
        "/backend"
        "/admin.php"
        "/admin.html"
        "/admin-panel"
        "/admin_area"
        "/admin-console"
    )

    echo -e "${blue}Начинаю поиск админ-панелей на сайте $url...${reset}"

    # Перебор путей и проверка их доступности
    for path in "${admin_paths[@]}"; do
        full_url="${url}${path}"
        response=$(curl -s -o /dev/null -w "%{http_code}" "$full_url")

        if [[ "$response" == "200" ]]; then
            echo -e "${green}[+] Найдена админ-панель: ${full_url}${reset}"
        elif [[ "$response" == "403" ]]; then
            echo -e "${yellow}[!] Доступ запрещен: ${full_url}${reset}"
        else
            echo -e "${red}[-] Не найдено: ${full_url}${reset}"
        fi
    done

    echo -e "${blue}Поиск завершен.${reset}"
    echo "Нажмите Enter, чтобы вернуться в главное меню."
    read -p ""
}

# Функция для генерации популярных dork-запросов
generate_dorks() {
    echo -e "${blue}Генерация популярных dork-запросов...${reset}"
    echo "Выберите категорию для генерации dork-запросов:"
    echo "1. Поиск файлов"
    echo "2. Поиск админ-панелей"
    echo "3. Поиск уязвимостей"
    echo "4. Поиск баз данных"
    echo "5. Показать все популярные dork-запросы"
    read -p "Введите номер категории: " category

    case $category in
        1)
            echo -e "${blue}Dork-запросы для поиска файлов:${reset}"
            echo "site:example.com filetype:pdf"
            echo "site:example.com filetype:docx"
            echo "site:example.com filetype:xls"
            echo "site:example.com filetype:csv"
            ;;
        2)
            echo -e "${blue}Dork-запросы для поиска админ-панелей:${reset}"
            echo "site:example.com inurl:admin"
            echo "site:example.com inurl:login"
            echo "site:example.com inurl:dashboard"
            echo "site:example.com inurl:control"
            ;;
        3)
            echo -e "${blue}Dork-запросы для поиска уязвимостей:${reset}"
            echo "site:example.com intext:error"
            echo "site:example.com intext:warning"
            echo "site:example.com ext:php intitle:index.of"
            echo "site:example.com inurl:wp-content"
            ;;
        4)
            echo -e "${blue}Dork-запросы для поиска баз данных:${reset}"
            echo "site:example.com filetype:sql"
            echo "site:example.com intext:mysql"
            echo "site:example.com intext:database"
            echo "site:example.com ext:db"
            ;;
        5)
            echo -e "${blue}Популярные dork-запросы:${reset}"
            echo "site:example.com filetype:pdf"
            echo "site:example.com inurl:admin"
            echo "site:example.com intext:error"
            echo "site:example.com filetype:sql"
            echo "site:example.com ext:php intitle:index.of"
            echo "site:example.com inurl:wp-content"
            echo "site:example.com intext:mysql"
            echo "site:example.com intext:database"
            ;;
        *)
            echo -e "${red}Неверный выбор. Попробуйте снова.${reset}"
            ;;
    esac
}

database_finder() {
    echo -e "${blue}Поиск баз данных...${reset}"
    echo "Эта функция предназначена для поиска открытых баз данных."
    read -p "Введите IP-адрес для анализа: " ip
    nmap -p 3306 "$ip"
}

admin_bypasser_v1() {
    echo -e "${blue}Обход защиты админ-панели V1...${reset}"
    echo "Эта функция предназначена для обучения методам защиты."
    echo "Попробуйте использовать стандартные пути, такие как /admin или /login."
}

# Функция для получения открытой информации о телефонном номере
phone_info() {
    echo -e "${blue}Получение информации о телефонном номере...${reset}"
    read -p "Введите телефонный номер (в международном формате, например, +14155552671): " phone_number

    # Проверка, что номер не пустой
    if [[ -z "$phone_number" ]]; then
        echo -e "${red}Ошибка: Телефонный номер не может быть пустым.${reset}"
        return
    fi

    # API ключ (замените YOUR_API_KEY на ваш реальный ключ)
    API_KEY="1e8c7bb7ed764330bbca9c4f1a45d9c0"
    API_URL="https://phonevalidation.abstractapi.com/v1/"

    # Выполнение запроса к API
    response=$(curl -s "${API_URL}?api_key=${API_KEY}&phone=${phone_number}")

    # Проверка ответа
    if [[ $(echo "$response" | jq -r '.valid') == "true" ]]; then
        country_name=$(echo "$response" | jq -r '.country.name')
        country_code=$(echo "$response" | jq -r '.country.code')
        carrier=$(echo "$response" | jq -r '.carrier')
        phone_type=$(echo "$response" | jq -r '.type')

        echo -e "${blue}Информация о номере:${reset}"
        echo "Страна: $country_name ($country_code)"
        echo "Оператор: $carrier"
        echo "Тип номера: $phone_type"
    else
        echo -e "${red}Не удалось получить информацию о номере. Проверьте формат номера или API-ключ.${reset}"
    fi
}

# Функция для анализа логов DOFOX
dofox_logs() {
    echo -e "${blue}Анализ логов DOFOX...${reset}"
    read -p "Введите путь к файлу логов: " log_file

    # Проверка существования файла
    if [[ ! -f "$log_file" ]]; then
        echo -e "${red}Ошибка: Файл логов не найден.${reset}"
        return
    fi

    echo -e "${blue}Анализируем файл: $log_file${reset}"

    # 1. Поиск подозрительных IP-адресов
    echo -e "${blue}Подозрительные IP-адреса (частые запросы):${reset}"
    awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 10

    # 2. Поиск попыток SQL-инъекций
    echo -e "\n${blue}Попытки SQL-инъекций:${reset}"
    grep -i -E "union|select|insert|drop|delete|alter|exec" "$log_file" | awk '{print $1, $7}' | uniq

    # 3. Поиск XSS-атак
    echo -e "\n${blue}Попытки XSS-атак:${reset}"
    grep -i -E "<script>|javascript:" "$log_file" | awk '{print $1, $7}' | uniq

    # 4. Поиск ошибок доступа (403, 404, 500)
    echo -e "\n${blue}Ошибки доступа (403, 404, 500):${reset}"
    awk '$9 ~ /403|404|500/' "$log_file" | awk '{print $1, $7, $9}' | uniq

    echo -e "\n${blue}Анализ завершен.${reset}"
}

auto_dork() {
    echo -e "${blue}Автоматическая генерация dork-запросов...${reset}"
    echo "Генерация запросов для поиска уязвимостей."
    echo "Примеры запросов:"
    echo "site:example.com intitle:index.of"
    echo "inurl:wp-content"
}

camera_security() {
    echo -e "${blue}Анализ безопасности камер...${reset}"
    echo "Эта функция предназначена для проверки безопасности ваших собственных камер."
    echo "Используйте только с разрешения владельца."
}

homework() {
    echo -e "${blue}Домашнее задание...${reset}"
    echo "Здесь вы можете выполнять задания по кибербезопасности."
}

script_executor() {
    echo -e "${blue}Выполнение скриптов...${reset}"
    echo "Введите путь к скрипту для выполнения."
    read -p "Путь к скрипту: " script
    bash "$script"
}

ping_site() {
    echo -e "${blue}Проверка доступности сайта...${reset}"
    read -p "Введите URL сайта: " url
    ping -c 4 "$url"
}

security_training() {
    echo -e "${blue}Обучение по безопасности...${reset}"
    echo "Здесь вы можете изучить основы кибербезопасности."
}

mass_scan() {
    echo -e "${blue}Массовая проверка сайтов...${reset}"
    echo "Введите список сайтов для проверки."
    read -p "Путь к файлу со списком сайтов: " file
    while read -r site; do
        nikto -h "$site"
    done < "$file"
}

wifi_analysis() {
    echo -e "${blue}Анализ Wi-Fi сетей...${reset}"
    echo "Эта функция предназначена для анализа вашей собственной сети."
    iwlist wlan0 scan
}

# Функция автоматического анализа уязвимостей
auto_exploit() {
    echo -e "${blue}Запуск автоматического анализа уязвимостей...${reset}"
    
    # Анимация загрузки (5 секунд)
    echo -ne "${yellow}["
    for i in {1..5}; do
        echo -ne "#"
        sleep 1
    done
    echo -e "] Готово!${reset}"

    # Основная логика анализа
    echo -e "${blue}Анализ выполняется только для образовательных целей.${reset}"
    read -p "Введите URL сайта для анализа: " url

    if [[ -z "$url" ]]; then
        echo -e "${red}Ошибка: URL не может быть пустым.${reset}"
        return
    fi

    echo -e "${blue}Начинаю анализ сайта $url...${reset}"

    # Пример использования инструмента nikto для сканирования уязвимостей
    nikto -h "$url"

    echo -e "${blue}Анализ завершен.${reset}"
}

admin_bypasser_v2() {
    echo -e "${blue}Обход защиты админ-панели V2...${reset}"
    echo "Эта функция предназначена для обучения методам защиты."
    echo "Попробуйте использовать стандартные пути, такие как /admin или /login."
}

more_options() {
    echo -e "${blue}Дополнительно...${reset}"
    echo "Здесь вы можете найти дополнительные инструменты."
}

# Проверка пароля перед запуском программы
check_password

# Запуск программы
main_menu
