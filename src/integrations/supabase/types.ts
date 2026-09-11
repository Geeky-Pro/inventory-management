export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      audit_logs: {
        Row: {
          action: string
          changed_at: string
          changed_by: string | null
          diff: Json | null
          id: string
          record_id: string | null
          table_name: string
        }
        Insert: {
          action: string
          changed_at?: string
          changed_by?: string | null
          diff?: Json | null
          id?: string
          record_id?: string | null
          table_name: string
        }
        Update: {
          action?: string
          changed_at?: string
          changed_by?: string | null
          diff?: Json | null
          id?: string
          record_id?: string | null
          table_name?: string
        }
        Relationships: [
          {
            foreignKeyName: "audit_logs_changed_by_fkey"
            columns: ["changed_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      categories: {
        Row: {
          created_at: string
          created_by: string | null
          id: string
          name_ar: string
          name_en: string | null
          parent_id: string | null
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          id?: string
          name_ar: string
          name_en?: string | null
          parent_id?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          created_at?: string
          created_by?: string | null
          id?: string
          name_ar?: string
          name_en?: string | null
          parent_id?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "categories_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "categories_parent_id_fkey"
            columns: ["parent_id"]
            isOneToOne: false
            referencedRelation: "categories"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "categories_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      currencies: {
        Row: {
          code: string
          is_base: boolean
          name_ar: string
          name_en: string
          symbol: string
        }
        Insert: {
          code: string
          is_base?: boolean
          name_ar: string
          name_en: string
          symbol: string
        }
        Update: {
          code?: string
          is_base?: boolean
          name_ar?: string
          name_en?: string
          symbol?: string
        }
        Relationships: []
      }
      customers: {
        Row: {
          created_at: string
          created_by: string | null
          id: string
          name: string
          notes: string | null
          phone: string | null
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          id?: string
          name: string
          notes?: string | null
          phone?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          created_at?: string
          created_by?: string | null
          id?: string
          name?: string
          notes?: string | null
          phone?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "customers_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "customers_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      debt_transactions: {
        Row: {
          amount: number
          amount_local: number
          created_at: string
          created_by: string | null
          currency_code: string
          customer_id: string
          exchange_rate: number
          id: string
          invoice_ref: string | null
          notes: string | null
          payment_method: string | null
          reference_id: string | null
          reference_table: string | null
          transaction_date: string
          transaction_type: string
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          amount: number
          amount_local: number
          created_at?: string
          created_by?: string | null
          currency_code: string
          customer_id: string
          exchange_rate?: number
          id?: string
          invoice_ref?: string | null
          notes?: string | null
          payment_method?: string | null
          reference_id?: string | null
          reference_table?: string | null
          transaction_date?: string
          transaction_type: string
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          amount?: number
          amount_local?: number
          created_at?: string
          created_by?: string | null
          currency_code?: string
          customer_id?: string
          exchange_rate?: number
          id?: string
          invoice_ref?: string | null
          notes?: string | null
          payment_method?: string | null
          reference_id?: string | null
          reference_table?: string | null
          transaction_date?: string
          transaction_type?: string
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "debt_transactions_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "debt_transactions_currency_code_fkey"
            columns: ["currency_code"]
            isOneToOne: false
            referencedRelation: "currencies"
            referencedColumns: ["code"]
          },
          {
            foreignKeyName: "debt_transactions_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customer_balances"
            referencedColumns: ["customer_id"]
          },
          {
            foreignKeyName: "debt_transactions_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "debt_transactions_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      exchange_rates: {
        Row: {
          created_at: string
          created_by: string | null
          currency_code: string
          id: string
          rate_date: string
          rate_to_base: number
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          currency_code: string
          id?: string
          rate_date?: string
          rate_to_base: number
        }
        Update: {
          created_at?: string
          created_by?: string | null
          currency_code?: string
          id?: string
          rate_date?: string
          rate_to_base?: number
        }
        Relationships: [
          {
            foreignKeyName: "exchange_rates_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "exchange_rates_currency_code_fkey"
            columns: ["currency_code"]
            isOneToOne: false
            referencedRelation: "currencies"
            referencedColumns: ["code"]
          },
        ]
      }
      item_images: {
        Row: {
          created_at: string
          created_by: string | null
          id: string
          is_primary: boolean
          item_id: string
          sort_order: number
          storage_path: string
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          id?: string
          is_primary?: boolean
          item_id: string
          sort_order?: number
          storage_path: string
        }
        Update: {
          created_at?: string
          created_by?: string | null
          id?: string
          is_primary?: boolean
          item_id?: string
          sort_order?: number
          storage_path?: string
        }
        Relationships: [
          {
            foreignKeyName: "item_images_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "item_images_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "item_stock"
            referencedColumns: ["item_id"]
          },
          {
            foreignKeyName: "item_images_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "items"
            referencedColumns: ["id"]
          },
        ]
      }
      item_units: {
        Row: {
          conversion_factor: number
          created_at: string
          created_by: string | null
          id: string
          is_base_unit: boolean
          is_purchase_default: boolean
          item_id: string
          last_purchase_price_local: number | null
          unit_id: string
          updated_at: string
        }
        Insert: {
          conversion_factor?: number
          created_at?: string
          created_by?: string | null
          id?: string
          is_base_unit?: boolean
          is_purchase_default?: boolean
          item_id: string
          last_purchase_price_local?: number | null
          unit_id: string
          updated_at?: string
        }
        Update: {
          conversion_factor?: number
          created_at?: string
          created_by?: string | null
          id?: string
          is_base_unit?: boolean
          is_purchase_default?: boolean
          item_id?: string
          last_purchase_price_local?: number | null
          unit_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "item_units_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "item_units_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "item_stock"
            referencedColumns: ["item_id"]
          },
          {
            foreignKeyName: "item_units_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "items"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "item_units_unit_id_fkey"
            columns: ["unit_id"]
            isOneToOne: false
            referencedRelation: "units"
            referencedColumns: ["id"]
          },
        ]
      }
      items: {
        Row: {
          category_id: string | null
          code: string | null
          created_at: string
          created_by: string | null
          id: string
          last_purchase_price_local: number | null
          name_ar: string
          name_en: string | null
          notes: string | null
          unit_id: string | null
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          category_id?: string | null
          code?: string | null
          created_at?: string
          created_by?: string | null
          id?: string
          last_purchase_price_local?: number | null
          name_ar: string
          name_en?: string | null
          notes?: string | null
          unit_id?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          category_id?: string | null
          code?: string | null
          created_at?: string
          created_by?: string | null
          id?: string
          last_purchase_price_local?: number | null
          name_ar?: string
          name_en?: string | null
          notes?: string | null
          unit_id?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "items_category_id_fkey"
            columns: ["category_id"]
            isOneToOne: false
            referencedRelation: "categories"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "items_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "items_unit_id_fkey"
            columns: ["unit_id"]
            isOneToOne: false
            referencedRelation: "units"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "items_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      permission_group_items: {
        Row: {
          group_id: string
          permission_key: string
        }
        Insert: {
          group_id: string
          permission_key: string
        }
        Update: {
          group_id?: string
          permission_key?: string
        }
        Relationships: [
          {
            foreignKeyName: "permission_group_items_group_id_fkey"
            columns: ["group_id"]
            isOneToOne: false
            referencedRelation: "permission_groups"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "permission_group_items_permission_key_fkey"
            columns: ["permission_key"]
            isOneToOne: false
            referencedRelation: "permissions"
            referencedColumns: ["key"]
          },
        ]
      }
      permission_groups: {
        Row: {
          created_at: string
          description: string | null
          id: string
          name: string
        }
        Insert: {
          created_at?: string
          description?: string | null
          id?: string
          name: string
        }
        Update: {
          created_at?: string
          description?: string | null
          id?: string
          name?: string
        }
        Relationships: []
      }
      permissions: {
        Row: {
          category: string
          key: string
          label_ar: string
          label_en: string
        }
        Insert: {
          category: string
          key: string
          label_ar: string
          label_en: string
        }
        Update: {
          category?: string
          key?: string
          label_ar?: string
          label_en?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          avatar_url: string | null
          created_at: string
          full_name: string | null
          id: string
          is_active: boolean
          locale: string
          updated_at: string
          username: string
        }
        Insert: {
          avatar_url?: string | null
          created_at?: string
          full_name?: string | null
          id: string
          is_active?: boolean
          locale?: string
          updated_at?: string
          username: string
        }
        Update: {
          avatar_url?: string | null
          created_at?: string
          full_name?: string | null
          id?: string
          is_active?: boolean
          locale?: string
          updated_at?: string
          username?: string
        }
        Relationships: []
      }
      purchase_invoice_items: {
        Row: {
          conversion_factor: number
          created_at: string
          created_by: string | null
          id: string
          invoice_id: string
          item_id: string
          item_unit_id: string | null
          line_total_local: number
          price_foreign: number | null
          price_local: number
          quantity: number
          updated_by: string | null
        }
        Insert: {
          conversion_factor?: number
          created_at?: string
          created_by?: string | null
          id?: string
          invoice_id: string
          item_id: string
          item_unit_id?: string | null
          line_total_local: number
          price_foreign?: number | null
          price_local: number
          quantity: number
          updated_by?: string | null
        }
        Update: {
          conversion_factor?: number
          created_at?: string
          created_by?: string | null
          id?: string
          invoice_id?: string
          item_id?: string
          item_unit_id?: string | null
          line_total_local?: number
          price_foreign?: number | null
          price_local?: number
          quantity?: number
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "purchase_invoice_items_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "purchase_invoice_items_invoice_id_fkey"
            columns: ["invoice_id"]
            isOneToOne: false
            referencedRelation: "purchase_invoices"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "purchase_invoice_items_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "item_stock"
            referencedColumns: ["item_id"]
          },
          {
            foreignKeyName: "purchase_invoice_items_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "items"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "purchase_invoice_items_item_unit_id_fkey"
            columns: ["item_unit_id"]
            isOneToOne: false
            referencedRelation: "item_units"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "purchase_invoice_items_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      purchase_invoices: {
        Row: {
          created_at: string
          created_by: string | null
          currency_code: string
          exchange_rate: number
          id: string
          invoice_date: string
          invoice_no: string
          notes: string | null
          payment_type: string
          status: string
          supplier_id: string | null
          total_foreign: number
          total_local: number
          updated_at: string
          updated_by: string | null
          voided_at: string | null
          voided_by: string | null
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          currency_code: string
          exchange_rate?: number
          id?: string
          invoice_date?: string
          invoice_no: string
          notes?: string | null
          payment_type?: string
          status?: string
          supplier_id?: string | null
          total_foreign?: number
          total_local?: number
          updated_at?: string
          updated_by?: string | null
          voided_at?: string | null
          voided_by?: string | null
        }
        Update: {
          created_at?: string
          created_by?: string | null
          currency_code?: string
          exchange_rate?: number
          id?: string
          invoice_date?: string
          invoice_no?: string
          notes?: string | null
          payment_type?: string
          status?: string
          supplier_id?: string | null
          total_foreign?: number
          total_local?: number
          updated_at?: string
          updated_by?: string | null
          voided_at?: string | null
          voided_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "purchase_invoices_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "purchase_invoices_currency_code_fkey"
            columns: ["currency_code"]
            isOneToOne: false
            referencedRelation: "currencies"
            referencedColumns: ["code"]
          },
          {
            foreignKeyName: "purchase_invoices_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "supplier_balances"
            referencedColumns: ["supplier_id"]
          },
          {
            foreignKeyName: "purchase_invoices_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "suppliers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "purchase_invoices_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "purchase_invoices_voided_by_fkey"
            columns: ["voided_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      stock_movements: {
        Row: {
          created_at: string
          created_by: string | null
          id: string
          item_id: string
          movement_date: string
          movement_type: string
          notes: string | null
          quantity: number
          reference_id: string | null
          reference_table: string | null
          unit_price_local: number
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          id?: string
          item_id: string
          movement_date?: string
          movement_type: string
          notes?: string | null
          quantity: number
          reference_id?: string | null
          reference_table?: string | null
          unit_price_local?: number
        }
        Update: {
          created_at?: string
          created_by?: string | null
          id?: string
          item_id?: string
          movement_date?: string
          movement_type?: string
          notes?: string | null
          quantity?: number
          reference_id?: string | null
          reference_table?: string | null
          unit_price_local?: number
        }
        Relationships: [
          {
            foreignKeyName: "stock_movements_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "stock_movements_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "item_stock"
            referencedColumns: ["item_id"]
          },
          {
            foreignKeyName: "stock_movements_item_id_fkey"
            columns: ["item_id"]
            isOneToOne: false
            referencedRelation: "items"
            referencedColumns: ["id"]
          },
        ]
      }
      supplier_transactions: {
        Row: {
          amount: number
          amount_local: number
          created_at: string
          created_by: string | null
          currency_code: string
          exchange_rate: number
          id: string
          invoice_ref: string | null
          notes: string | null
          payment_method: string | null
          reference_id: string | null
          reference_table: string | null
          supplier_id: string
          transaction_date: string
          transaction_type: string
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          amount: number
          amount_local: number
          created_at?: string
          created_by?: string | null
          currency_code: string
          exchange_rate: number
          id?: string
          invoice_ref?: string | null
          notes?: string | null
          payment_method?: string | null
          reference_id?: string | null
          reference_table?: string | null
          supplier_id: string
          transaction_date?: string
          transaction_type: string
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          amount?: number
          amount_local?: number
          created_at?: string
          created_by?: string | null
          currency_code?: string
          exchange_rate?: number
          id?: string
          invoice_ref?: string | null
          notes?: string | null
          payment_method?: string | null
          reference_id?: string | null
          reference_table?: string | null
          supplier_id?: string
          transaction_date?: string
          transaction_type?: string
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "supplier_transactions_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "supplier_transactions_currency_code_fkey"
            columns: ["currency_code"]
            isOneToOne: false
            referencedRelation: "currencies"
            referencedColumns: ["code"]
          },
          {
            foreignKeyName: "supplier_transactions_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "supplier_balances"
            referencedColumns: ["supplier_id"]
          },
          {
            foreignKeyName: "supplier_transactions_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "suppliers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "supplier_transactions_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      suppliers: {
        Row: {
          created_at: string
          created_by: string | null
          default_currency: string | null
          default_payment_type: string
          id: string
          name: string
          notes: string | null
          phone: string | null
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          default_currency?: string | null
          default_payment_type?: string
          id?: string
          name: string
          notes?: string | null
          phone?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          created_at?: string
          created_by?: string | null
          default_currency?: string | null
          default_payment_type?: string
          id?: string
          name?: string
          notes?: string | null
          phone?: string | null
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "suppliers_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "suppliers_default_currency_fkey"
            columns: ["default_currency"]
            isOneToOne: false
            referencedRelation: "currencies"
            referencedColumns: ["code"]
          },
          {
            foreignKeyName: "suppliers_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      units: {
        Row: {
          created_at: string
          id: string
          name_ar: string
          name_en: string
        }
        Insert: {
          created_at?: string
          id?: string
          name_ar: string
          name_en: string
        }
        Update: {
          created_at?: string
          id?: string
          name_ar?: string
          name_en?: string
        }
        Relationships: []
      }
      user_permission_groups: {
        Row: {
          created_by: string | null
          group_id: string
          user_id: string
        }
        Insert: {
          created_by?: string | null
          group_id: string
          user_id: string
        }
        Update: {
          created_by?: string | null
          group_id?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_permission_groups_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "user_permission_groups_group_id_fkey"
            columns: ["group_id"]
            isOneToOne: false
            referencedRelation: "permission_groups"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "user_permission_groups_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      user_permissions: {
        Row: {
          created_by: string | null
          permission_key: string
          user_id: string
        }
        Insert: {
          created_by?: string | null
          permission_key: string
          user_id: string
        }
        Update: {
          created_by?: string | null
          permission_key?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_permissions_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "user_permissions_permission_key_fkey"
            columns: ["permission_key"]
            isOneToOne: false
            referencedRelation: "permissions"
            referencedColumns: ["key"]
          },
          {
            foreignKeyName: "user_permissions_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      customer_balances: {
        Row: {
          balance: number | null
          customer_id: string | null
          name: string | null
          phone: string | null
          total_credit: number | null
          total_debit: number | null
        }
        Relationships: []
      }
      customer_statement: {
        Row: {
          amount: number | null
          amount_local: number | null
          created_at: string | null
          created_by: string | null
          currency_code: string | null
          customer_id: string | null
          exchange_rate: number | null
          id: string | null
          invoice_ref: string | null
          notes: string | null
          payment_method: string | null
          reference_id: string | null
          reference_table: string | null
          running_balance_local: number | null
          transaction_date: string | null
          transaction_type: string | null
        }
        Relationships: [
          {
            foreignKeyName: "debt_transactions_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "debt_transactions_currency_code_fkey"
            columns: ["currency_code"]
            isOneToOne: false
            referencedRelation: "currencies"
            referencedColumns: ["code"]
          },
          {
            foreignKeyName: "debt_transactions_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customer_balances"
            referencedColumns: ["customer_id"]
          },
          {
            foreignKeyName: "debt_transactions_customer_id_fkey"
            columns: ["customer_id"]
            isOneToOne: false
            referencedRelation: "customers"
            referencedColumns: ["id"]
          },
        ]
      }
      item_stock: {
        Row: {
          category_id: string | null
          code: string | null
          current_quantity: number | null
          item_id: string | null
          last_purchase_price_local: number | null
          name_ar: string | null
          name_en: string | null
          stock_value: number | null
          unit_id: string | null
        }
        Relationships: [
          {
            foreignKeyName: "items_category_id_fkey"
            columns: ["category_id"]
            isOneToOne: false
            referencedRelation: "categories"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "items_unit_id_fkey"
            columns: ["unit_id"]
            isOneToOne: false
            referencedRelation: "units"
            referencedColumns: ["id"]
          },
        ]
      }
      supplier_balances: {
        Row: {
          balance: number | null
          name: string | null
          phone: string | null
          supplier_id: string | null
          total_credit: number | null
          total_debit: number | null
        }
        Relationships: []
      }
      supplier_statement: {
        Row: {
          amount: number | null
          amount_local: number | null
          created_at: string | null
          created_by: string | null
          currency_code: string | null
          exchange_rate: number | null
          id: string | null
          invoice_ref: string | null
          notes: string | null
          payment_method: string | null
          reference_id: string | null
          reference_table: string | null
          running_balance_local: number | null
          supplier_id: string | null
          transaction_date: string | null
          transaction_type: string | null
        }
        Relationships: [
          {
            foreignKeyName: "supplier_transactions_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "supplier_transactions_currency_code_fkey"
            columns: ["currency_code"]
            isOneToOne: false
            referencedRelation: "currencies"
            referencedColumns: ["code"]
          },
          {
            foreignKeyName: "supplier_transactions_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "supplier_balances"
            referencedColumns: ["supplier_id"]
          },
          {
            foreignKeyName: "supplier_transactions_supplier_id_fkey"
            columns: ["supplier_id"]
            isOneToOne: false
            referencedRelation: "suppliers"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Functions: {
      add_customer_opening_balance: {
        Args: {
          _amount_local: number
          _currency_code: string
          _customer_id: string
          _exchange_rate: number
          _notes?: string
          _operation_id: string
          _transaction_date: string
        }
        Returns: string
      }
      add_supplier_opening_balance: {
        Args: {
          _amount_local: number
          _currency_code: string
          _exchange_rate: number
          _notes?: string
          _operation_id: string
          _supplier_id: string
          _transaction_date: string
        }
        Returns: string
      }
      adjust_stock: {
        Args: {
          _item_id: string
          _movement_date: string
          _notes?: string
          _operation_id: string
          _quantity_delta: number
          _unit_price_local: number
        }
        Returns: string
      }
      admin_delete_user_data: {
        Args: { p_actor_id: string; p_user_id: string }
        Returns: undefined
      }
      admin_update_profile: {
        Args: {
          p_actor_id: string
          p_full_name: string
          p_is_active: boolean
          p_user_id: string
          p_username: string
        }
        Returns: {
          avatar_url: string | null
          created_at: string
          full_name: string | null
          id: string
          is_active: boolean
          locale: string
          updated_at: string
          username: string
        }
        SetofOptions: {
          from: "*"
          to: "profiles"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      audit_log_diff: { Args: { new_row: Json; old_row: Json }; Returns: Json }
      create_purchase_invoice: {
        Args: {
          _currency_code: string
          _exchange_rate: number
          _invoice_date: string
          _invoice_no: string
          _items: Json
          _notes: string
          _payment_type: string
          _supplier_id: string
          _total_foreign: number
          _total_local: number
        }
        Returns: string
      }
      current_user_has_permission: {
        Args: { _permission: string }
        Returns: boolean
      }
      has_permission: {
        Args: { _permission: string; _user_id: string }
        Returns: boolean
      }
      is_admin: { Args: { _user_id: string }; Returns: boolean }
      pay_supplier: {
        Args: {
          _amount_local: number
          _currency_code: string
          _exchange_rate: number
          _notes?: string
          _operation_id: string
          _payment_method: string
          _supplier_id: string
          _transaction_date: string
        }
        Returns: string
      }
      record_customer_payment: {
        Args: {
          _amount_local: number
          _currency_code: string
          _customer_id: string
          _exchange_rate: number
          _notes?: string
          _operation_id: string
          _payment_method: string
          _transaction_date: string
        }
        Returns: string
      }
      set_audit_changed_by: { Args: { audit_uid: string }; Returns: undefined }
      void_purchase_invoice: {
        Args: { _invoice_id: string }
        Returns: undefined
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {},
  },
} as const
