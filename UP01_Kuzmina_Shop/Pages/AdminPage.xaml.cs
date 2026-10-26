using System;
using System.Windows;
using System.Windows.Controls;

namespace UP01_Kuzmina_Shop.Pages
{
    public partial class AdminPage : Page
    {
        public AdminPage()
        {
            InitializeComponent();
        }

        // Переход к управлению пользователями (создадим на следующем шаге)
        private void BtnUsers_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new UsersTabPage());
        }

        // Заглушки для будущих страниц
        private void BtnProducts_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Страница товаров в разработке", "Внимание");
        }

        private void BtnSales_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Страница продаж в разработке", "Внимание");
        }

        private void BtnDiagrams_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Страница диаграмм в разработке", "Внимание");
        }

        // Выход из аккаунта
        private void BtnLogout_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Вы действительно хотите выйти из аккаунта?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                NavigationService?.Navigate(new AuthPage());
            }
        }
    }
}