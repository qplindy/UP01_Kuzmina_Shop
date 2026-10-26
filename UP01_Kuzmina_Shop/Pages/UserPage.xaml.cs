using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using UP01_Kuzmina_Shop;

namespace UP01_Kuzmina_Shop.Pages
{
    public partial class UserPage : Page
    {
        public UserPage()
        {
            InitializeComponent();
        }

        // Событие загрузки страницы (вызывается, когда все элементы уже созданы)
        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            LoadCategories(); // Загружаем категории
            LoadData();       // Загружаем товары
        }

        // Загрузка категорий для фильтрации
        private void LoadCategories()
        {
            using (var db = new SHOPINGEntities())
            {
                var categories = db.categories.ToList();

                // Добавляем пункт "Все категории" в начало
                var list = new List<object> { new { category_id = 0, name = "Все категории" } };
                list.AddRange(categories);

                CbCategory.ItemsSource = list;
                CbCategory.DisplayMemberPath = "name";
                CbCategory.SelectedValuePath = "category_id";
                CbCategory.SelectedIndex = 0; // Выбираем "Все категории"
            }
        }

        // Основной метод загрузки и фильтрации товаров
        private void LoadData()
        {
            // Защита от вызова до полной инициализации страницы
            if (!IsInitialized) return;

            using (var db = new SHOPINGEntities())
            {
                // Берем все товары из БД
                var products = db.products.ToList();

                // 1. Поиск по названию или бренду
                if (!string.IsNullOrWhiteSpace(TbSearch.Text))
                {
                    string search = TbSearch.Text.ToLower();
                    products = products.Where(p =>
                        (p.name != null && p.name.ToLower().Contains(search)) ||
                        (p.brand != null && p.brand.ToLower().Contains(search))
                    ).ToList();
                }

                // 2. Фильтрация по категории (с проверкой на null)
                if (CbCategory != null && CbCategory.SelectedValue != null && (int)CbCategory.SelectedValue != 0)
                {
                    int catId = (int)CbCategory.SelectedValue;
                    products = products.Where(p => p.category_id == catId).ToList();
                }

                // 3. Сортировка по цене
                if (CbSort.SelectedIndex == 0)
                    products = products.OrderBy(p => p.retail_price).ToList();
                else
                    products = products.OrderByDescending(p => p.retail_price).ToList();

                // Привязываем к таблице
                DataGridProducts.ItemsSource = products;
            }
        }

        // Обработчики событий изменения фильтров
        private void TbSearch_TextChanged(object sender, TextChangedEventArgs e) { LoadData(); }
        private void CbSort_SelectionChanged(object sender, SelectionChangedEventArgs e) { LoadData(); }
        private void CbCategory_SelectionChanged(object sender, SelectionChangedEventArgs e) { LoadData(); }

        // Выход
        private void BtnLogout_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Вы действительно хотите выйти?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes)
            {
                NavigationService?.Navigate(new AuthPage());
            }
        }
    }
}