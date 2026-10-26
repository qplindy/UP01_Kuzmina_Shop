using System;
using System.Windows;
using System.Windows.Threading;
using System.Configuration;

namespace UP01_Kuzmina_Shop
{
    public partial class MainWindow : Window
    {
        DispatcherTimer timer = new DispatcherTimer();

        // Переменная, которая запоминает текущую тему ("Light" или "Dark")
        private string currentTheme = "Light";

        public MainWindow()
        {
            InitializeComponent();

            timer.Interval = TimeSpan.FromSeconds(1);
            timer.Tick += Timer_Tick;
            timer.Start();

            LoadTheme();
        }

        private void Timer_Tick(object sender, EventArgs e)
        {
            TbDateTime.Text = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            MainFrame.Navigate(new Pages.AuthPage());
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Вы действительно хотите выйти?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.No)
            {
                e.Cancel = true;
            }
        }

        // Кнопка смены темы
        private void BtnTheme_Click(object sender, RoutedEventArgs e)
        {
            // Проверяем, какая тема сейчас активна, и переключаем на другую
            if (currentTheme == "Light")
            {
                ChangeTheme("DictionaryDark.xaml");
                SaveTheme("Dark");
                currentTheme = "Dark"; // Запоминаем, что теперь темная
            }
            else
            {
                ChangeTheme("Dictionary.xaml");
                SaveTheme("Light");
                currentTheme = "Light"; // Запоминаем, что теперь светлая
            }
        }

        // Метод для загрузки словаря стилей
        private void ChangeTheme(string themeName)
        {
            var uri = new Uri(themeName, UriKind.Relative);
            ResourceDictionary resourceDict = Application.LoadComponent(uri) as ResourceDictionary;

            // Очищаем старые стили и загружаем новые
            Application.Current.Resources.Clear();
            Application.Current.Resources.MergedDictionaries.Add(resourceDict);
        }

        // Сохранение темы в настройки
        private void SaveTheme(string theme)
        {
            Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            config.AppSettings.Settings["Theme"].Value = theme;
            config.Save(ConfigurationSaveMode.Modified);
        }

        // Загрузка сохраненной темы при запуске
        private void LoadTheme()
        {
            string theme = ConfigurationManager.AppSettings["Theme"];
            if (theme == "Dark")
            {
                ChangeTheme("DictionaryDark.xaml");
                currentTheme = "Dark"; // Если загрузили темную, запоминаем это
            }
            else
            {
                currentTheme = "Light"; // Иначе светлая
            }
        }
    }
}