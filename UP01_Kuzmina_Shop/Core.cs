using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UP01_Kuzmina_Shop
{
    // Этот класс будет хранить данные о том, кто сейчас вошел в систему
    public static class Core
    {
        public static SHOPINGEntities Context = new SHOPINGEntities();
        public static Users CurrentUser { get; set; }
    }
}