{application,eRM,
             [{applications,[kernel,stdlib,elixir,logger,runtime_tools,
                             gettext,phoenix_pubsub,cowboy,phoenix_html,
                             phoenix,postgrex,geo_postgis,phoenix_ecto]},
              {description,"eRM"},
              {modules,['Elixir.ERM','Elixir.ERM.Application',
                        'Elixir.ERM.Contexts','Elixir.ERM.Cooperation',
                        'Elixir.ERM.Cooperation.EI','Elixir.ERM.Cooperators',
                        'Elixir.ERM.Cooperators.Cooperator',
                        'Elixir.ERM.Cooperators.Credential',
                        'Elixir.ERM.Cooperators.KeyPair',
                        'Elixir.ERM.DataCase','Elixir.ERM.Measuring',
                        'Elixir.ERM.Monitoring','Elixir.ERM.PostgresTypes',
                        'Elixir.ERM.Repo','Elixir.ERM.Scoring.FourReturns',
                        'Elixir.ERM.Verifying','Elixir.ERMWeb',
                        'Elixir.ERMWeb.ChannelCase','Elixir.ERMWeb.ConnCase',
                        'Elixir.ERMWeb.CooperatorController',
                        'Elixir.ERMWeb.CooperatorView',
                        'Elixir.ERMWeb.EIController','Elixir.ERMWeb.EIView',
                        'Elixir.ERMWeb.Endpoint','Elixir.ERMWeb.ErrorHelpers',
                        'Elixir.ERMWeb.ErrorView','Elixir.ERMWeb.Gettext',
                        'Elixir.ERMWeb.LayoutView',
                        'Elixir.ERMWeb.PageController',
                        'Elixir.ERMWeb.PageView','Elixir.ERMWeb.Router',
                        'Elixir.ERMWeb.Router.Helpers',
                        'Elixir.ERMWeb.SessionController',
                        'Elixir.ERMWeb.SessionView',
                        'Elixir.ERMWeb.UserSocket']},
              {registered,[]},
              {vsn,"0.0.1"},
              {mod,{'Elixir.ERM.Application',[]}},
              {extra_applications,[logger,runtime_tools]}]}.