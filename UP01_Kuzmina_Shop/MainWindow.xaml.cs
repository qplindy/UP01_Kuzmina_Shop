using System;
using System.Windows;
using System.Windows.Threading;
using System.Configuration; // Для сохранения настроек

namespace UP01_Kuzmina_Shop
{
    public partial class MainWindow : Window
    {
        // Таймер для обновления времени
        DispatcherTimer timer = new DispatcherTimer();

        public MainWindow()
        {
            InitializeComponent();

            // Запускаем таймер для часов
            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += Timer_Tick;
            timer.Start();

            // При запуске загружаем сохраненную тему (если нет, то светлую)
            LoadTheme();
        }

        // Обновление времени каждую секунду
        private void Timer_Tick(object sender, EventArgs e)
        {
            TbDateTime.Text = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
        }

        // Событие загрузки окна (можно оставить пустым, оно есть в XAML)
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            // Переходим сразу на страницу авторизации
            MainFrame.Navigate(new Pages.AuthPage());
        }

        // Подтверждение выхода из приложения
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Вы действительно хотите выйти?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.No)
            {
                e.Cancel = true; // Отменяем закрытие
            }
        }

        // Переключение темы
        private void BtnTheme_Click(object sender, RoutedEventArgs e)
        {
            // Определяем текущую тему и переключаем на противоположную
            if (Application.Current.Resources.MergedDictionaries[0].Source.OriginalString == "Dictionary.xaml")
            {
                ChangeTheme("DictionaryDark.xaml");
                SaveTheme("Dark");
            }
            else
            {
                ChangeTheme("Dictionary.xaml");
                SaveTheme("Light");
            }
        }

        // Метод для загрузки словаря стилей
        private void ChangeTheme(string themeName)
        {
            var uri = new Uri(themeName, UriKind.Relative);
            ResourceDictionary resourceDict = Application.LoadComponent(uri) as ResourceDictionary;
            Application.Current.Resources.Clear();
            Application.Current.Resources.MergedDictionaries.Add(resourceDict);
        }

        // Сохранение темы в настройки (чтобы при следующем запуске она запомнилась)
        private void SaveTheme(string theme)
        {
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            config.AppSettings.Settings["Theme"].Value = theme;
            config.Save(ConfigurationSaveMode.Modified);
        }

        // Загрузка сохраненной темы
        private void LoadTheme()
        {
            string theme = ConfigurationManager.AppSettings["Theme"];
            if (theme == "Dark")
            {
                ChangeTheme("DictionaryDark.xaml");
            }
        }
    }
}